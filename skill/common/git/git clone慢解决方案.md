git clone特别慢是因为[github.global.ssl.fastly.net](http://github.global.ssl.fastly.net)域名被限制了。只要找到这个域名对应的ip地址，然后在hosts文件中加上ip–>域名的映射，刷新DNS缓存便可

1. 编辑hosts   `sudo vi /private/etc/hosts`
2. 在/etc/hosts文件里面增加几行ip映射就可以了。

可以使用[ipaddress.com在线](http://ipaddress.com)网站查询下面两个网址的ip地址

151.101.76.249 [github.global.ssl.fastly.net](http://github.global.ssl.fastly.net) 

192.30.253.112 [github.com](http://github.com)

3. 将上面两行ip映射关系追加在/etc/hosts文件后面即可。接下来要让这个变更生效就可以了。 
`sudo dscacheutil -flushcache`