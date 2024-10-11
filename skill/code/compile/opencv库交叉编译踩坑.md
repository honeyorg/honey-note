#cross-compilation #build #opencv #ffmpeg 

网上也有人遇到的，交叉编译linux库时，videoio模块没有ffmpeg，导致库编出来了，编译运行也不报错，就是视频加载不出来

那么如何编译时包含ffmpeg呢？根据detect_ffmpeg.cmake代码来看，可以直接给系统安装libavcodec等库，但这样跨平台会出问题。

所以坑就来到了如何用自己的编译工具链和系统库来交叉编译ffmpeg库，以及编出来的库如何让opencv索引到。交叉编译ffmpeg请注意，因为我使用的编译工具链和网上博主的都不一样。我是用ue提供的clang进行交叉编译。前期configure阶段一直不通过，总会说我指定的c编译器不能编译出一个可执行文件。可以通过ffbuild/config.log 日志文件，结尾部分看到蛛丝马迹。比如ld不可用，比如-l依赖的库不存在等等等等。

后来我意识到，ffmpeg是一个c库，因此不能完全照搬ue的c++编译流程。这些配置好之后，编译时又遇到了问题，ffmpeg的函数和系统库函数同名，且前者为静态函数，后者又是非静态函数。导致编译一直不通过。后来修改了ld可执行文件。

再之后就是编译出来的ffmpeg放在opencv时检索不到，根据日志提示，禁用了pkg-config，如何正确设置，可以用export的方式在sh终端预设环境变量PKG_CONFIG_PATH等变量。也可以在cmake中通过set(ENV{PKG_CONFIG_PATH} /path)的方式设置环境变量。这些设置好之后，差不多就能搜索到avcodec等库的版本号了。但是ffmpeg总开关还是off，并且日志中可能会出现不能找到包AVCODEC的日志。明明已经输出了库版本，结果还有这样的日志，我发现是由于ffmpeg make install安装后产生的pc文件内部给的路径是编译机器的绝对路径，但我已经将安装目录迁移到另一个目录了，因此会出这种警告日志。

另外编译不通过时，可以把编译日志输出出来，就在detect_ffmpeg.cmake中结尾附近。try_compile的结尾部分。输出日志可以查看到具体原因。

我遇到了两种原因，第一种是undefined reference avcodec::*，其说明符号没有索引到，应该是编译时给了不正确的选项。查看后发现我设置—extra-flags=“fvisibility=hidden”这个标识说明编译出来的符号都是不可见的，所以印证了编译报错。

等删除这个标识，流程重新来，又遇到了第二个问题。编译时说GLIBC版本号什么的，大致意思就是系统库不匹配，opencv交叉编译时使用的系统库中，找不到ffmpeg库依赖的对应版本的系统库。再次查看ffmpeg，发现没有设置sysroot，添加了sysroot之后流程再来。基本就差不到了。

如果又遇到了问题，对，其实我还遇到了第三个问题，说ffmpeg依赖的liblzma什么的库是在电脑的系统库，但是编译时不能有效索引到。这里就很恼火了。根据位置无关和运行时搜索库运行路径的概念。我已经设置了—enable-pic标识却出这种报错。后来，我又追加了-fPIC 在extra-cflags中。问题解决

这下再在opencv编译，ffmpeg测试文件通过，总开关打开。此时就可以编译opencv库了，会将ffmpeg功能包含在内，且使用的ffmpeg库也是交叉编译出来的，和opencv以及ue使用的一套工具链。

对了，在我的opencv交叉编译中，我也向cflags追加了-fPIC，打出来的[libopencv_world.so](http://libopencv_world.so)还有ffmpeg的so放在同一个目录下。ldd查找依赖可以看到索引的是当前路径下的ffmpeg库而不是之前安装在电脑系统库路径下的ffmpeg了。再尝试换一台电脑，电脑上没有ffmpeg，但是ldd索引依旧正常，功能可用，总算大功告成

  

  

上面的解决办法还有一些小问题，RPATH指定的路径是相当于当前目录的，而不是相对于可执行文件所在的目录，那么当换一个目录再执行上面的程序，就会又报找不到共享库。解决这个问题的办法就是使用$ORIGIN变量，在运行的时候，链接器会将该变量的值用可执行文件所在的目录来替换，这样我们就又能相对于可执行文件来指定RPATH了。重新编译如下：

gcc -L. -larith main.c -Wl,-rpath='$ORIGIN/' -o main

**patchelf****命令**

很多时候我们拿到的是编译好的二进制文件，这样我们就不能用前面的办法来指定RPATH了。幸好有patchelf这个小工具，它可以用来修改elf文件，用它修改main的RPATH的方法如下：

pathelf  main --set-rpath='$ORIGIN/'