 #clang   #ue   #cross-compilation 

Windows下首先要下载clang编译工具，在UE官网中进行下载，不同的UE引擎版本有对应的clang下载包链接。

下载后进行安装，路径无所谓，因为要配置到系统环境变量中。

设置系统环境变量LINUX_MULTIARCH_ROOT，指向的路径为当前所需要用到的clang路径，例如：C:\UnrealToolchains\v21_clang-15.0.1-centos7

请注意，该环境变量不支持设置以分号分隔的多个clang版本路径，UE的识别逻辑如此。

修改好环境变量后，不需要重启电脑，只需要重启UE编辑器即可，UE会在编辑器启动阶段读取该环境变量信息，识别linux编译工具集

linux toolchain交叉编译链下载地址：
[交叉编译工具链文档](https://dev.epicgames.com/documentation/en-us/unreal-engine/linux-development-requirements-for-unreal-engine?application_version=5.5)

从UE5.5之后，下载的clang不是centos7版本的了，改为了rockylinux8的。该操作系统还没有玩过，不晓得其兼不兼容此前用cengos7的clang工具链编译的linux平台的第三方库。

