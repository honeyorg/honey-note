如果是在很老的系统上编译，如国产的统信UOS，使用的g++虽然也支持c++2a标准。但是如果用到了例如filesystem库，需要额外依赖stdc++fs库，否则链接时会报错

另外webrtc库依赖了X11库，linux开发电脑需要安装x11，命令是apt install libx11-dev，注意x是小写