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

