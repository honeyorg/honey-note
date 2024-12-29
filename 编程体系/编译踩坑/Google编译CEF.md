 #gn   #cef   #google   #deptool  

cef编译指南官方链接：[bitbucket.org/chromiumembedded/cef/wiki/MasterBuildQuickStart.md](https://bitbucket.org/chromiumembedded/cef/wiki/MasterBuildQuickStart.md)

windows平台下推荐使用visual studio编译，需要注意如果vs没有安装在默认目录下，可能需要针对官方文档给出的步骤做部分修改，如设置一下环境变量，来使构建脚本识别路径，可以在create.bat中添加如下代码。create.bat是在chromium/src/cef路径下的

set GYP_MSVS_VERSION=2022

set vs_root=D:\Program Files\Microsoft Visual Studio\2022\Professional

set vc_tools_version=14.37.32822

set vs_crt_root=%vs_root%\VC\Tools\MSVC\%vc_tools_version%\crt

set vc_redist_version=14.34.31931

set vc_redist_crt=Microsoft.VC143.CRT

set sdk_root=C:\Program Files (x86)\Windows Kits\10

set sdk_version=10.0.22621.0

set arch=x64

set WIN_CUSTOM_TOOLCHAIN=1

  

set CEF_VCVARS=none

set GYP_MSVS_OVERRIDE_PATH=%vs_root%

set VS_CRT_ROOT=%vs_crt_root%

set SDK_ROOT=%sdk_root%

set PATH=%PATH%;%sdk_root%\bin\%sdk_version%\x64;%vs_root%\VC\Tools\MSVC\%vc_tools_version%\bin\HostX64\x64;%vs_root%\VC\Redist\MSVC\%vc_redist_version%\x64\%vc_redist_crt%;%vs_root%\SystemCRT

set LIB=%LIB%;%sdk_root%\Lib\%sdk_version%\um\%arch%;%sdk_root%\Lib\%sdk_version%\ucrt\%arch%;%vs_root%\VC\Tools\MSVC\%vc_tools_version%\lib\%arch%;%vs_root%\VC\Tools\MSVC\%vc_tools_version%\atlmfc\lib\%arch%

set INCLUDE=%INCLUDE%;%sdk_root%\Include\%sdk_version%\um;%sdk_root%\Include\%sdk_version%\ucrt;%sdk_root%\Include\%sdk_version%\shared;%vs_root%\VC\Tools\MSVC\%vc_tools_version%\include;%vs_root%\VC\Tools\MSVC\%vc_tools_version%\atlmfc\include

  

set GN_DEFINES=is_component_build=true proprietary_codecs=true enable_platform_hevc=true media_use_ffmpeg=true ffmpeg_branding=Chrome

set GN_ARGUMENTS=--ide=vs2022 --sln=cef --filters=//cef/*

call cef_create_projects.bat

  

◯ 查找cef可以设置的全部GN_DEFINES参数及含义，以供后续高级版编译

有一个注意点，如果你想在下载cef和chromium源码阶段直接设置分支，update.bat里面的代码修改成类似python3 automate-git.py --branch=6045 --download-dir=d:\Workspace\Chromium\new --depot-tools-dir=d:\Workspace\depot_tools --no-distrib --no-build --force-clean

其中—branch=6045即指定了源码下载的分支。

如果需要自定义cef文件夹里面tests的代码，请注意，因为编译时[CMakeLists.txt.in](http://CMakeLists.txt.in)是模版文件，里面有一个插入标记符，是由脚本驱动从其他文件中找到类似于包含头文件、源码文件等配置来动态插入的，因此如果自定义了代码，可以寻找对应的文件来修改文件列表。例如，我修改了tests/cefclient代码，新增了几个源码文件，我找到了cef_paths.gypi和cef_paths2.gypi，只要在这里面找到对应的字符，然后添加源码路径就可以被编译进去

此外还需注意，GN_DEFINES中建议使用use_sysroot=true，这样就是使用chromium内置的sysroot，可以在不同的linux上兼容