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

结果配置阶段还是报错，后来通过调试cmake代码，发现找到的`bison`不是`/opt/homebrew/opt/`下的，故直接添加`-DBISON_EXECUTABLE=/opt/homebrew/opt/bison/bin/bison`，配置成功！

然后在cmake的编译目标中选择了`mysqlclient`，生成了我需要的`libmysqlclient.a`