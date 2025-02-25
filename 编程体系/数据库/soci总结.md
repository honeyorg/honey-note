#db #soci #backend #sqlite #mysql #psql 

[官方文档](https://soci.sourceforge.net/doc/master/)

[mysql源码库](https://github.com/mysql/mysql-server)

[mysql8.0源码编译官方文档](https://dev.mysql.com/doc/refman/8.0/en/source-installation.html)

# mysql源码编译

需要先下载依赖boost，下载openssl，以及bison。

boost根据提示的下载url，下载压缩包，解压后，设置`-DWITH_BOOST=to/your/path`。而openssl的安装则需要通过`brew install openssl`来安装。注意，`mysql`的`8.0`分支下，查找的`openssl`依赖为`SET(OPENSSL_ROOT_DIR "${HOMEBREW_HOME}/openssl@1.1")`，我尝试使用`brew install openssl@1.1`，但是报错了，提示我该版本截止`2024-10-24`已经不支持了，所以我这里修改为了`openssl@3`。

之后又提示
```
If you have a newer bison in a non-standard location, you can do 'cmake -DBISON_EXECUTABLE=</path/to/bison-executable>'

We recommend Homebrew bison
```

因此我又通过`brew install bison`安装了`bison`

结果配置阶段还是报错，后来通过调试`cmake`代码，发现找到的`bison`不是`/opt/homebrew/opt/`下的，故直接添加`-DBISON_EXECUTABLE=/opt/homebrew/opt/bison/bin/bison`，配置成功！

然后在`cmake`的编译目标中选择了`mysqlclient`，生成了我需要的`libmysqlclient.a`

但是这个只是`soci`所需的库，并没有部署`mysql`服务，通过`install`安装`mysql`所有内容，其中的`bin`下有`mysqld`等可执行程序，这就是关键了。

我将`install`安装在了`/usr/local/mysql`目录下，并创建了`/usr/local/mysql/data`这个`data`目录。

之后在终端中来到`/user/local/mysql`目录下，输入`bin/mysqld --initialize --user=mysql`，其为我创建了`mysql`的默认账户`root`并生成了一个临时密码，记住这个密码。

然后再输入`bin/mysqld_safe --user=mysql &`，此时终端会被阻塞，`mysql`服务已经启动了，默认是`localhost:3306`

如果想检查服务是否启动，则输入`ps aux | grep mysqld`。如果能看到类似如下信息这说明服务在运行：

```shell
goderyu          87545   0.5  3.0 411859952 496016 s006  SN   11:03下午   0:01.89 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data --plugin-dir=/usr/local/mysql/lib/plugin --log-error=goderyudeMacBook-Pro.local.err --pid-file=goderyudeMacBook-Pro.local.pid
```

此后再开一个终端，输入`bin/mysql -u root -p`，这时会要求输入密码，请输入之前所说的生成的临时密码。验证成功后，终端会进入`mysql>`状态。

当然也可以使用数据库软件如`Navicat`去连接`mysql`数据库。

修改密码可以在连接了数据库后用此查询语句`ALTER USER 'root'@'localhost' IDENTIFIED BY 'new_password';`进行修改

## 启动服务

`bin/mysqld --user=mysql &`

## 停止服务

`bin/mysqladmin -u root -p shutdown`

## 循环执行SQL

不建议循环体内每次执行`sql`语句，因为每次都要解析语句进行准备

规范做法：使用`soci::statement`

例如：

```c++
int i; statement st = (sql.prepare << "insert into numbers(value) values(:val)", use(i));
for (i = 0; i != 100; ++i)
{
  st.execute(true);
}
```

## 封装TArray支持报错汇总

```log
Error: Vectors of size 0 are not allowed while executing "select * from user".
```

最终查看了源码及文档，`soci`说不支持对`orm`类型的批处理，即不支持`into<std::vector<UserType>>`和`user<std::vector<UserType>>`，所以也没法扩展封装`TArray`类型的，只能换一种实现方案，通过`while(st.fetch())`遍历查询的数据，执行组装数组。

## Undefined symbols for architecture arm64

```log
Undefined symbols for architecture arm64
"typeinfo for UObject", referenced from:
```

这个问题非常恶心，是出现在我集成`soci`库时，因为其库使用了`rtti`特性，所以我在`Build.cs`中设置了`bUseRTTI=true;`，结果就是因为开启了`rtti`，导致我的所有`UE的UObject及其子类`都没有办法编译通过。需要关了该选项。无奈查看了`soci`源码中使用了`typeid`的地方，发现只有一个`check_ptr_cast`接口使用了，而这个接口只在`get_from_uses`接口中使用了，其只是提供了一种保障，就是确保在使用`use`接口从调用端向数据库后端提供数据时，和数据库列的类型不匹配时抛出异常的。那我这里只能将代码注释了，会损失一部分完整性，但是能解决掉集成的问题。

# 源码解读

## 流式传输时逗号操作符重载原理

```c++
    once_temp_type & operator,(into_type_ptr const &);
    once_temp_type & operator,(use_type_ptr const &);

    template <typename T, typename Indicator>
    once_temp_type &operator,(into_container<T, Indicator> const &ic)
    {
        rcst_->exchange(ic);
        return *this;
    }
    template <typename T, typename Indicator>
    once_temp_type &operator,(use_container<T, Indicator> const &uc)
    {
        rcst_->exchange(uc);
        return *this;
    }
```

可以看到，能接受四种类型参数：
- `into_type_ptr`
- `use_type_ptr`
- `into_container`
- `use_container`

而`into_type_ptr`是通过特化模板函数`do_into`返回值返回出去的

来看一个`into`模板函数的特化：

```c++
template <typename T>
details::into_type_ptr into(std::vector<T> & t,
    std::size_t begin, std::size_t & end)
{
    return details::do_into(t, begin, &end,
        typename details::exchange_traits<std::vector<T> >::type_family());
}
```

通过`do_into`模板函数特化来进行构造，接着看`do_into`的特化实现：

```c++
template <typename T>
into_type_ptr do_into(std::vector<T> & t,
    std::size_t begin, std::size_t * end, basic_type_tag)
{
    return into_type_ptr(new into_type<std::vector<T> >(t, begin, end));
}
```

所以如果想要扩展支持`TArray`类型，**特化模板类`into_type<TArray<T>>`是必须的**


`into_type_ptr`是个别名，原始类型是`typedef type_ptr<into_type_base> into_type_ptr;`

那么反推可以得到，`std::vector`走的是：

```c++
template <typename T>
class into_type<std::vector<T> > : public vector_into_type
{
};
```

集成的父类`vector_into_type`的结构为：

```c++
class SOCI_DECL vector_into_type : public into_type_base
{
};
```

可以看出继承了`into_type_base`，而`type_ptr`只是一个包装类，代码如下：

```c++
template <typename T>
class type_ptr
{
public:
    type_ptr(T * p) : p_(p) {}
    ~type_ptr() { delete p_; }

    T * get() const { return p_; }
    void release() const { p_ = 0; }

private:
    mutable T * p_;
};
```

回到`vector_into_type`类实现上看一下原理：
其内部成员变量有几个关键的：
- `void* data_`：待存储的数组头指针
- `std::vector<indicator> * indVec_`：缓存后端数据库用的
- `std::size_t begin_`：待存储的数组头
- `std::size_t* end_`：待存储的数组尾
该类有几个函数，实现都没啥要注意的，主要是看`define`函数：

```c++
void vector_into_type::define(statement_impl & st, int & position)
{
    if (backEnd_ == NULL)
    {
        backEnd_ = st.make_vector_into_type_backend();
    }

    if (end_ != NULL)
    {
        backEnd_->define_by_pos_bulk(position, data_, type_, begin_, end_);
    }
    else
    {
        backEnd_->define_by_pos(position, data_, type_);
    }
}
```

这个位置对后端数据库类对象`backEnd_`调用`define_by_pos[_bulk]`，传递了`void* data_`，这个很关键，在后端数据库封装实现中，查阅源码得知，写死了会将这个`void* data_`通过`static_cast`转成`std::vector<T>*`。并且获取数组大小和设置数组大小均是先转型成`std::vector`，再分别调用`std::vector`的`size()`和`resize()`接口。所以到这一步，就**验证了这个`void* data_`不能想当然的赋值为`TArray`的头指针**

> 需要找一种策略，通过持有一个`std::vector`对象来承接从数据库查询到的数据。该数据通过`into`流程存储在`std::vector`中，需要找到存储完成的代码点，在这里进行扩展，通过`拷贝/移动`的方式转存在`TArray`中。

再观察`conversion_into_type`这个模板类，尤其是针对`std::vector`的特化类：

```c++
template <typename T>
class conversion_into_type<std::vector<T> >
    : private base_vector_holder<T>,
      public into_type<std::vector<typename type_conversion<T>::base_type> >
{
public:
    typedef typename std::vector
        <
            typename type_conversion<T>::base_type
        > base_type;

    conversion_into_type(std::vector<T> & value,
        std::size_t begin = 0, std::size_t * end = NULL)
        : base_vector_holder<T>(value.size()),
        into_type<base_type>(
            base_vector_holder<T>::vec_, ownInd_, begin, end),
        value_(value),
        ownInd_(),
        ind_(ownInd_),
        begin_(begin),
        end_(end)
    {
        user_ranges_ = end != NULL;
    }

    conversion_into_type(std::vector<T> & value, std::vector<indicator> & ind,
        std::size_t begin = 0, std::size_t * end = NULL)
        : base_vector_holder<T>(value.size()),
        into_type<base_type>(
            base_vector_holder<T>::vec_, ind, begin, end),
        value_(value),
        ind_(ind),
        begin_(begin),
        end_(end)
    {
        user_ranges_ = end != NULL;
    }

    std::size_t size() const override
    {
        // the user might have resized his vector in the meantime
        // -> synchronize the base-value mirror to have the same size

        std::size_t const userSize = value_.size();
        base_vector_holder<T>::vec_.resize(userSize);

        return into_type<base_type>::size();
    }

    void resize(std::size_t sz) override
    {
        into_type<base_type>::resize(sz);

        std::size_t actual_size = base_vector_holder<T>::vec_.size();
        value_.resize(actual_size);
        ind_.resize(actual_size);
    }

private:
    void convert_from_base() override
    {
        if (user_ranges_)
        {
            for (std::size_t i = begin_; i != *end_; ++i)
            {
                type_conversion<T>::from_base(
                    base_vector_holder<T>::vec_[i], ind_[i], value_[i]);
            }
        }
        else
        {
            std::size_t const sz = base_vector_holder<T>::vec_.size();

            for (std::size_t i = 0; i != sz; ++i)
            {
                type_conversion<T>::from_base(
                    base_vector_holder<T>::vec_[i], ind_[i], value_[i]);
            }
        }
    }

    std::vector<T> & value_;

    std::vector<indicator> ownInd_;

    // ind_ refers to either ownInd_, or the one provided by the user
    // in any case, ind_ refers to some valid vector of indicators
    // and can be used by conversion routines
    std::vector<indicator> & ind_;

    std::size_t begin_;
    std::size_t * end_;
    bool user_ranges_;

    SOCI_NOT_COPYABLE(conversion_into_type)
};
```

几个关键点：
- `size`接口：获取数组大小，它这里通过用户持有的`value_`引用，获取其大小，将底层需要用的`base_vector_holder<T>::vec_`的大小进行了`resize`同步。为什么`::vec_`就是底层持有而`value_`是用户持有呢？因为`value_`是被构造函数中的第一个参数`std::vector& value_`赋值的，而同时在构造函数中构造`into_type`时，传入的`std::vector&`用来承接数据库数据的`vector`是`::vec_`。从这里可以看出，已经进行了隔离，那就可以从这里入手，将用户传入的`std::vector`改为`TArray`，而传给后端的还是保持`std::vector`。那么什么时候能将数据从`std::vector`转移到`TArray`呢？看后面的`convert_from_base`接口
- `resize`接口：和上面同理，既然已经理清楚了隔离的两个数组，`resize`的实现就好理解了，其获取了后端持有的`::vec_.size()`，然后对用户持有的`value_.resize`，这里就可以改成`TArray`的重置数组大小的方法`value_.SetNum`。
- `convert_from_base`接口：很关键，将其中的`value_[i]`更换为`TArray`对象的指定索引的地址，这样就能将数据转移到`TArray`中。


理清思路后，我实现了`conversion_into_type`的`TArray`特化模板类：

```c++
        template <typename T>
        class conversion_into_type<TArray<T>>
            : private base_vector_holder<T>,
              public into_type<std::vector<typename type_conversion<T>::base_type>>
        {
        public:
            typedef typename std::vector<
                typename type_conversion<T>::base_type>
                base_type;

            conversion_into_type(TArray<T> &value,
                                 std::size_t begin = 0, std::size_t *end = NULL)
                : base_vector_holder<T>(value.Num()),
                  into_type<base_type>(
                      base_vector_holder<T>::vec_, ownInd_, begin, end),
                  value_(value),
                  ownInd_(),
                  ind_(ownInd_),
                  begin_(begin),
                  end_(end)
            {
                user_ranges_ = end != NULL;
            }

            conversion_into_type(TArray<T> &value, std::vector<indicator> &ind,
                                 std::size_t begin = 0, std::size_t *end = NULL)
                : base_vector_holder<T>(value.Num()),
                  into_type<base_type>(
                      base_vector_holder<T>::vec_, ind, begin, end),
                  value_(value),
                  ind_(ind),
                  begin_(begin),
                  end_(end)
            {
                user_ranges_ = end != NULL;
            }

            std::size_t size() const override
            {
                // the user might have resized his vector in the meantime
                // -> synchronize the base-value mirror to have the same size

                std::size_t const userSize = value_.Num();
                base_vector_holder<T>::vec_.resize(userSize);

                return into_type<base_type>::size();
            }

            void resize(std::size_t sz) override
            {
                into_type<base_type>::resize(sz);

                std::size_t actual_size = base_vector_holder<T>::vec_.size();
                value_.SetNum(actual_size);
                ind_.resize(actual_size);
            }

        private:
            void convert_from_base() override
            {
                if (user_ranges_)
                {
                    for (std::size_t i = begin_; i != *end_; ++i)
                    {
                        type_conversion<T>::from_base(
                            base_vector_holder<T>::vec_[i], ind_[i], value_[i]);
                    }
                }
                else
                {
                    std::size_t const sz = base_vector_holder<T>::vec_.size();

                    for (std::size_t i = 0; i != sz; ++i)
                    {
                        type_conversion<T>::from_base(
                            base_vector_holder<T>::vec_[i], ind_[i], value_[i]);
                    }
                }
            }

            TArray<T> &value_;

            std::vector<indicator> ownInd_;

            // ind_ refers to either ownInd_, or the one provided by the user
            // in any case, ind_ refers to some valid vector of indicators
            // and can be used by conversion routines
            std::vector<indicator> &ind_;

            std::size_t begin_;
            std::size_t *end_;
            bool user_ranges_;

            SOCI_NOT_COPYABLE(conversion_into_type)
        };
```

可以看到这里直接将用户持有的`std::vector`全部换成了`TArray`，后端持有的数组保持`std::vector`不变，编译报错，说没有对应的`exchange_traits`特化模板。又添加了

```c++
        template <typename T>
        struct exchange_traits<TArray<T>>
        {
            typedef typename exchange_traits<T>::type_family type_family;
            enum
            {
                x_type = exchange_traits<T>::x_type
            };
        };
```

至此编译通过，写了测试代码来查询数据：

```c++
		TArray<int> ids;
		ids.SetNumUninitialized(10);
		sql << "SELECT id FROM users", soci::into(ids);

		UE_LOG(LogHoney, Log, TEXT("Query result: %d"), ids.Num());
```
预期输出数组尺寸为`1`，但是输出结果为`10`，数组大小没重置

```log
LogHoney: Query result: 10
```


# 批量操作

```c++
int i;
statement st = (sql.prepare << "select value from numbers order by value", into(i));
st.execute();
while (st.fetch())
{
  cout << i << '\n';
}
```

# 建表

```c++
            sql.begin();
            sql << "create table soci_test("
                        "name varchar(100) not null primary key, "
                        "age integer not null"
                   ")";
            sql.commit();
```