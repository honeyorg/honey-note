### Linux下使用指定编译器来编译代码

在CMakeLists.txt中，添加以下代码：
```cmake 
set(CMAKE_SYSROOT "/home/goderyu/Downloads/UnrealEngine-5.2/Engine/Extras/ThirdPartyNotUE/SDKs/HostLinux/Linux_x64/v21_clang-15.0.1-centos7/x86_64-unknown-linux-gnu")
set(LIBCXX_DIR "/home/goderyu/Downloads/UnrealEngine-5.2/Engine/Source/ThirdParty/Unix/LibCxx/include/c++/v1")

set(CMAKE_C_COMPILER ${CMAKE_SYSROOT}/bin/clang)
set(CMAKE_CXX_COMPILER ${CMAKE_SYSROOT}/bin/clang++)
set(CMAKE_BUILD_WITH_INSTALL_RPATH on)
set(CMAKE_POSITION_INDEPENDENT_CODE on)
set(LIBCXX_ROOT "/home/goderyu/Downloads/UnrealEngine-5.2/Engine/Source/ThirdParty/Unix/LibCxx/lib/Unix/x86_64-unknown-linux-gnu")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -nostdinc++ -I${LIBCXX_DIR} -w -L${LIBCXX_ROOT} -l${LIBCXX_ROOT}/libc++.a -l${LIBCXX_ROOT}/libc++abi.a")

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
```

如果使用的是VSCode结合CMake Tools插件来编译代码，找到编译器缓存配置文件
`/home/goderyu/.local/share/CMakeTools/cmake-tools-kits.json`

在里面添加SYSROOT中指定的编译器
```json
{
    "name": "v21_clang x86_64-linux-gnu",
    "compilers": {
        "C": "/home/goderyu/Downloads/UnrealEngine-5.2/Engine/Extras/ThirdPartyNotUE/SDKs/HostLinux/Linux_x64/v21_clang-15.0.1-centos7/x86_64-unknown-linux-gnu/bin/clang",
        "CXX": "/home/goderyu/Downloads/UnrealEngine-5.2/Engine/Extras/ThirdPartyNotUE/SDKs/HostLinux/Linux_x64/v21_clang-15.0.1-centos7/x86_64-unknown-linux-gnu/bin/clang++"
    },
    "isTrusted": true
}
```