 #net   #socket  

对于服务器，其通信流程一般如下所述。

1. 调用socket函数创建socket（监听socket）

2. 调用bind函数将socket绑定到某个IP和端口的二元组上

3. 调用listen函数开启监听

4. 当有客户端请求连接上来时，调用 accept 函数接收连接，产生一个新的 socket （客户端socket）

5. 基于新产生的socket调用send或recv函数，开始与客户端进行数据交流

6. 通信结束后，调用close函数关闭监听socket。

对于客户端，其通信流程一般如下所述。

1. 调用socket函数创建客户端socket

2. 调用connect函数尝试连接服务器

3. 连接成功后调用send或recv函数，开始与服务器进行数据交流

4. 通信结束后，调用close函数关闭监听socket