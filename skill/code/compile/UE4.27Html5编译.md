#ue #cross-compilation #build #cmake #ems 

首先，第三方库得用emsdk提供的编译器进行编译


找到VSCode，CMake Tools插件的kits配置文件`cmake-tools-kits.json`，添加如下配置：
```json
  {
    "name": "emsdk 3.1.56",
    "compilers": {
      "C": "D:\\Dev\\UE-HTML5-4.27\\Engine\\Platforms\\HTML5\\Build\\emsdk\\emsdk-3.1.56\\upstream\\emscripten\\emcc.bat",
      "CXX": "D:\\Dev\\UE-HTML5-4.27\\Engine\\Platforms\\HTML5\\Build\\emsdk\\emsdk-3.1.56\\upstream\\emscripten\\em++.bat"
    },
    "isTrusted": true
  }
```

没用，编译不了测试源码。


emcmake cmake ..的逻辑，会执行`cmake .. -DCMAKE_TOOLCHAIN_FILE=D:\Dev\UE-HTML5-4.27\Engine\Platforms\HTML5\Build\emsdk\emsdk-3.1.56\upstream\emscripten\cmake\Modules\Platform\Emscripten.cmake -DCMAKE_CROSSCOMPILING_EMULATOR=D:/Dev/UE-HTML5-4.27/Engine/Platforms/HTML5/Build/emsdk/emsdk-3.1.56/node/16.20.0_64bit/bin/node.exe -G Ninja`

查看`Emscripten.cmake`源码，发现其设置了toolchain的一些属性，例如，`CMAKE_SYSTEM_NAME=Emscripten`，`CMAKE_C_COMPILER=path/emcc.bat`等，因此我不需要在VSCode中去借助CMake Tools插件来进行一些工具链的设置等，且要注意一个细节。
不要用VSCode打开cmake工程，其会默认生成build文件夹，且自动索引到的编译器是msvc的，这样会导致我在终端中执行`emcmake cmake ..`时，遇到报错，说无法找到上一次的编译器`VS MSVC 2022`之类的字样。

执行的日志如下：
```txt
configure: cmake .. -DCMAKE_TOOLCHAIN_FILE=D:\Dev\UE-HTML5-4.27\Engine\Platforms\HTML5\Build\emsdk\emsdk-3.1.56\upstream\emscripten\cmake\Modules\Platform\Emscripten.cmake -DCMAKE_CROSSCOMPILING_EMULATOR=D:/Dev/UE-HTML5-4.27/Engine/Platforms/HTML5/Build/emsdk/emsdk-3.1.56/node/16.20.0_64bit/bin/node.exe -G Ninja
-- EMSDK=
-- Building tiff version 4.5.1
-- libtiff library version 6.0.1
-- libtiff build date: 20241021
-- Performing Test C_FLAG_Wall
-- Performing Test C_FLAG_Wall - Success
-- Performing Test C_FLAG_Winline
-- Performing Test C_FLAG_Winline - Success
-- Performing Test C_FLAG_Wformat_security
-- Performing Test C_FLAG_Wformat_security - Success
-- Performing Test C_FLAG_Wpointer_arith
-- Performing Test C_FLAG_Wpointer_arith - Success
-- Performing Test C_FLAG_Wdisabled_optimization
-- Performing Test C_FLAG_Wdisabled_optimization - Success
-- Performing Test C_FLAG_Wno_unknown_pragmas
-- Performing Test C_FLAG_Wno_unknown_pragmas - Success
-- Performing Test C_FLAG_fstrict_aliasing
-- Performing Test C_FLAG_fstrict_aliasing - Success
-- Performing Test HAVE_LD_VERSION_SCRIPT
-- Performing Test HAVE_LD_VERSION_SCRIPT - Success
-- Looking for assert.h
-- Looking for assert.h - found
-- Looking for fcntl.h
-- Looking for fcntl.h - found
-- Looking for io.h
-- Looking for io.h - not found
-- Looking for strings.h
-- Looking for strings.h - found
-- Looking for sys/time.h
-- Looking for sys/time.h - found
-- Looking for sys/types.h
-- Looking for sys/types.h - found
-- Looking for unistd.h
-- Looking for unistd.h - found
-- Looking for getopt
-- Looking for getopt - found
-- Looking for optarg
-- Looking for optarg - found
-- Looking for mmap
-- Looking for mmap - found
-- Looking for setmode
-- Looking for setmode - not found
-- Looking for stdint.h
-- Looking for stdint.h - found
-- Looking for stddef.h
-- Looking for stddef.h - found
-- Check size of size_t
-- Check size of size_t - done
-- Could NOT find ZLIB (missing: ZLIB_LIBRARY ZLIB_INCLUDE_DIR)
-- Could NOT find Deflate (missing: Deflate_LIBRARY Deflate_INCLUDE_DIR)
-- Could NOT find JPEG (missing: JPEG_LIBRARY JPEG_INCLUDE_DIR)
-- Could NOT find JBIG (missing: JBIG_LIBRARY JBIG_INCLUDE_DIR)
-- Could NOT find LERC (missing: LERC_LIBRARY LERC_INCLUDE_DIR)
-- Could NOT find liblzma (missing: LIBLZMA_LIBRARY LIBLZMA_INCLUDE_DIR LIBLZMA_HAS_AUTO_DECODER LIBLZMA_HAS_EASY_ENCODER LIBLZMA_HAS_LZMA_PRESET)
-- Could NOT find ZSTD (missing: ZSTD_LIBRARY ZSTD_INCLUDE_DIR)
-- Could NOT find WebP (missing: WebP_LIBRARY WebP_INCLUDE_DIR)
-- Could NOT find GLUT (missing: GLUT_glut_LIBRARY)
-- Looking for GL/gl.h
-- Looking for GL/gl.h - found
-- Looking for GL/glu.h
-- Looking for GL/glu.h - found
-- Looking for GL/glut.h
-- Looking for GL/glut.h - found
-- Looking for GLUT/glut.h
-- Looking for GLUT/glut.h - not found
-- Looking for OpenGL/gl.h
-- Looking for OpenGL/gl.h - not found
-- Looking for OpenGL/glu.h
-- Looking for OpenGL/glu.h - not found
-- Looking for pow
-- Looking for pow - found
-- Found CMath: TRUE
CMake Warning (dev) at libtiff/CMakeLists.txt:48 (add_library):
  ADD_LIBRARY called with SHARED option but the target platform does not
  support dynamic linking.  Building a STATIC library instead.  This may lead
  to problems.
This warning is for project developers.  Use -Wno-dev to suppress it.

CMake Warning (dev) at libtiff/CMakeLists.txt:222 (add_library):
  ADD_LIBRARY called with SHARED option but the target platform does not
  support dynamic linking.  Building a STATIC library instead.  This may lead
  to problems.
This warning is for project developers.  Use -Wno-dev to suppress it.

CMake Deprecation Warning at doc/CMakeLists.txt:27 (cmake_minimum_required):
  Compatibility with CMake < 3.5 will be removed from a future version of
  CMake.

  Update the VERSION argument <min> value or use a ...<max> suffix to tell
  CMake that the project does not need compatibility with older versions.


-- Found Python3: D:/Program Files/Python312/python.exe (found version "3.12.2") found components: Interpreter
-- Looking for sphinx-build - not found
--
-- Libtiff is now configured for Emscripten-1
--
--   Installation directory:             D:/Dev/UE-HTML5-4.27/Engine/Platforms/HTML5/Build/emsdk/emsdk-3.1.56/upstream/emscripten/cache/sysroot
--   Documentation directory:            share/doc/tiff
--   C compiler:                         D:/Dev/UE-HTML5-4.27/Engine/Platforms/HTML5/Build/emsdk/emsdk-3.1.56/upstream/emscripten/emcc.bat
--   C++ compiler:                       D:/Dev/UE-HTML5-4.27/Engine/Platforms/HTML5/Build/emsdk/emsdk-3.1.56/upstream/emscripten/em++.bat
--   Build shared libraries:             ON
--   Build tools:                        ON
--   Build tests:                        ON
--   Build contrib:                      ON
--   Build docs:                         ON
--   Build deprecated features:          OFF
--   Enable linker symbol versioning:    TRUE
--   Support Microsoft Document Imaging: ON
--   Use win32 IO:                       OFF
--
--  Support for internal codecs:
--   CCITT Group 3 & 4 algorithms:       ON
--   Macintosh PackBits algorithm:       ON
--   LZW algorithm:                      ON
--   ThunderScan 4-bit RLE algorithm:    ON
--   NeXT 2-bit RLE algorithm:           ON
--   LogLuv high dynamic range encoding: ON
--
--  Support for external codecs:
--   ZLIB support:                       Requested:OFF Availability:FALSE Support:FALSE
--   libdeflate support:                 Requested:OFF Availability:FALSE Support:FALSE (Depends on ZLIB Support)
--   Pixar log-format algorithm:         Requested:OFF Availability:FALSE Support:FALSE (Depends on ZLIB Support)
--   JPEG support:                       Requested:OFF Availability:FALSE Support:FALSE
--   Old JPEG support:                   Requested:OFF Availability:FALSE Support:FALSE (Depends on JPEG Support)
--   JPEG 8/12 bit dual mode:            Requested:OFF Availability:FALSE Support:FALSE
--   ISO JBIG support:                   Requested:OFF Availability:FALSE Support:FALSE
--   LERC support:                       Requested:OFF Availability:FALSE Support:FALSE (Depends on ZLIB Support)
--   LZMA2 support:                      Requested:OFF Availability:FALSE Support:FALSE
--   ZSTD support:                       Requested:OFF Availability:FALSE Support:FALSE
--   WEBP support:                       Requested:OFF Availability:FALSE Support:FALSE
--
--   C++ support:                        ON (requested) TRUE (availability)
--
--   OpenGL support:                     Requested:OFF Availability:FALSE Support:FALSE
--
-- Configuring done (110.8s)
-- Generating done (0.1s)
-- Build files have been written to: D:/Dev/Html5/gdalnativeforue/tiff-4.5.1/build
```

下一步开始进行build，调用`emcmake make`，其又说make没有任务，根据之前的configure阶段的命令，我发现用了-G Ninja，而Ninja是不会生成Makefile的。我查看了一下`emcmake.bat`脚本，其执行了`emcmake.py`，在这个python脚本中，其有一段代码：
```python
  if utils.WINDOWS and not any(arg.startswith('-G') for arg in args):
    if shutil.which('mingw32-make'):
      args += ['-G', 'MinGW Makefiles']
    elif shutil.which('ninja'):
      args += ['-G', 'Ninja']
    else:
      print('emcmake: no compatible cmake generator found; Please install ninja or mingw32-make, or specify a generator explicitly using -G', file=sys.stderr)
      return 1
```

可以看到，我电脑中应该是没有安装过MinGW，于是我下载了一个MinGW，设置了环境变量的PATH。

现在我需要把之前的build文件夹清空，目的是防止缓存影响我的流程，然后再次执行一次`emcmake cmake ..`。

我在设置了PATH环境变量后，仍然是在之前的power shell中执行的命令，获取到的还是`-G Ninja`，我重新打开了一个power shell，再次执行，索引到了`-G MinGW Makefiles`，日志如下：
```txt
configure: cmake .. -DCMAKE_INSTALL_PREFIX=D:\Dev\Html5\gdalnativeforue\tiff-4.5.1\build\install -DCMAKE_TOOLCHAIN_FILE=D:\Dev\UE-HTML5-4.27\Engine\Platforms\HTML5\Build\emsdk\emsdk-3.1.56\upstream\emscripten\cmake\Modules\Platform\Emscripten.cmake -DCMAKE_CROSSCOMPILING_EMULATOR=D:/Dev/UE-HTML5-4.27/Engine/Platforms/HTML5/Build/emsdk/emsdk-3.1.56/node/16.20.0_64bit/bin/node.exe -G "MinGW Makefiles"
-- EMSDK=
-- Building tiff version 4.5.1
-- libtiff library version 6.0.1
-- libtiff build date: 20241021
-- Performing Test C_FLAG_Wall
-- Performing Test C_FLAG_Wall - Success
-- Performing Test C_FLAG_Winline
-- Performing Test C_FLAG_Winline - Success
-- Performing Test C_FLAG_Wformat_security
-- Performing Test C_FLAG_Wformat_security - Success
-- Performing Test C_FLAG_Wpointer_arith
-- Performing Test C_FLAG_Wpointer_arith - Success
-- Performing Test C_FLAG_Wdisabled_optimization
-- Performing Test C_FLAG_Wdisabled_optimization - Success
-- Performing Test C_FLAG_Wno_unknown_pragmas
-- Performing Test C_FLAG_Wno_unknown_pragmas - Success
-- Performing Test C_FLAG_fstrict_aliasing
-- Performing Test C_FLAG_fstrict_aliasing - Success
-- Performing Test HAVE_LD_VERSION_SCRIPT
-- Performing Test HAVE_LD_VERSION_SCRIPT - Success
-- Looking for assert.h
-- Looking for assert.h - found
-- Looking for fcntl.h
-- Looking for fcntl.h - found
-- Looking for io.h
-- Looking for io.h - not found
-- Looking for strings.h
-- Looking for strings.h - found
-- Looking for sys/time.h
-- Looking for sys/time.h - found
-- Looking for sys/types.h
-- Looking for sys/types.h - found
-- Looking for unistd.h
-- Looking for unistd.h - found
-- Looking for getopt
-- Looking for getopt - found
-- Looking for optarg
-- Looking for optarg - found
-- Looking for mmap
-- Looking for mmap - found
-- Looking for setmode
-- Looking for setmode - not found
-- Looking for stdint.h
-- Looking for stdint.h - found
-- Looking for stddef.h
-- Looking for stddef.h - found
-- Check size of size_t
-- Check size of size_t - done
-- Could NOT find ZLIB (missing: ZLIB_LIBRARY ZLIB_INCLUDE_DIR)
-- Could NOT find Deflate (missing: Deflate_LIBRARY Deflate_INCLUDE_DIR)
-- Could NOT find JPEG (missing: JPEG_LIBRARY JPEG_INCLUDE_DIR)
-- Could NOT find JBIG (missing: JBIG_LIBRARY JBIG_INCLUDE_DIR)
-- Could NOT find LERC (missing: LERC_LIBRARY LERC_INCLUDE_DIR)
-- Could NOT find liblzma (missing: LIBLZMA_LIBRARY LIBLZMA_INCLUDE_DIR LIBLZMA_HAS_AUTO_DECODER LIBLZMA_HAS_EASY_ENCODER LIBLZMA_HAS_LZMA_PRESET)
-- Could NOT find ZSTD (missing: ZSTD_LIBRARY ZSTD_INCLUDE_DIR)
-- Could NOT find WebP (missing: WebP_LIBRARY WebP_INCLUDE_DIR)
-- Could NOT find GLUT (missing: GLUT_glut_LIBRARY)
-- Looking for GL/gl.h
-- Looking for GL/gl.h - found
-- Looking for GL/glu.h
-- Looking for GL/glu.h - found
-- Looking for GL/glut.h
-- Looking for GL/glut.h - found
-- Looking for GLUT/glut.h
-- Looking for GLUT/glut.h - not found
-- Looking for OpenGL/gl.h
-- Looking for OpenGL/gl.h - not found
-- Looking for OpenGL/glu.h
-- Looking for OpenGL/glu.h - not found
-- Looking for pow
-- Looking for pow - found
-- Found CMath: TRUE
CMake Warning (dev) at libtiff/CMakeLists.txt:48 (add_library):
  ADD_LIBRARY called with SHARED option but the target platform does not
  support dynamic linking.  Building a STATIC library instead.  This may lead
  to problems.
This warning is for project developers.  Use -Wno-dev to suppress it.

CMake Warning (dev) at libtiff/CMakeLists.txt:222 (add_library):
  ADD_LIBRARY called with SHARED option but the target platform does not
  support dynamic linking.  Building a STATIC library instead.  This may lead
  to problems.
This warning is for project developers.  Use -Wno-dev to suppress it.

CMake Deprecation Warning at doc/CMakeLists.txt:27 (cmake_minimum_required):
  Compatibility with CMake < 3.5 will be removed from a future version of
  CMake.

  Update the VERSION argument <min> value or use a ...<max> suffix to tell
  CMake that the project does not need compatibility with older versions.


-- Found Python3: D:/Program Files/Python312/python.exe (found version "3.12.2") found components: Interpreter
-- Looking for sphinx-build - not found
--
-- Libtiff is now configured for Emscripten-1
--
--   Installation directory:             D:/Dev/Html5/gdalnativeforue/tiff-4.5.1/build/install
--   Documentation directory:            share/doc/tiff
--   C compiler:                         D:/Dev/UE-HTML5-4.27/Engine/Platforms/HTML5/Build/emsdk/emsdk-3.1.56/upstream/emscripten/emcc.bat
--   C++ compiler:                       D:/Dev/UE-HTML5-4.27/Engine/Platforms/HTML5/Build/emsdk/emsdk-3.1.56/upstream/emscripten/em++.bat
--   Build shared libraries:             ON
--   Build tools:                        ON
--   Build tests:                        ON
--   Build contrib:                      ON
--   Build docs:                         ON
--   Build deprecated features:          OFF
--   Enable linker symbol versioning:    TRUE
--   Support Microsoft Document Imaging: ON
--   Use win32 IO:                       OFF
--
--  Support for internal codecs:
--   CCITT Group 3 & 4 algorithms:       ON
--   Macintosh PackBits algorithm:       ON
--   LZW algorithm:                      ON
--   ThunderScan 4-bit RLE algorithm:    ON
--   NeXT 2-bit RLE algorithm:           ON
--   LogLuv high dynamic range encoding: ON
--
--  Support for external codecs:
--   ZLIB support:                       Requested:OFF Availability:FALSE Support:FALSE
--   libdeflate support:                 Requested:OFF Availability:FALSE Support:FALSE (Depends on ZLIB Support)
--   Pixar log-format algorithm:         Requested:OFF Availability:FALSE Support:FALSE (Depends on ZLIB Support)
--   JPEG support:                       Requested:OFF Availability:FALSE Support:FALSE
--   Old JPEG support:                   Requested:OFF Availability:FALSE Support:FALSE (Depends on JPEG Support)
--   JPEG 8/12 bit dual mode:            Requested:OFF Availability:FALSE Support:FALSE
--   ISO JBIG support:                   Requested:OFF Availability:FALSE Support:FALSE
--   LERC support:                       Requested:OFF Availability:FALSE Support:FALSE (Depends on ZLIB Support)
--   LZMA2 support:                      Requested:OFF Availability:FALSE Support:FALSE
--   ZSTD support:                       Requested:OFF Availability:FALSE Support:FALSE
--   WEBP support:                       Requested:OFF Availability:FALSE Support:FALSE
--
--   C++ support:                        ON (requested) TRUE (availability)
--
--   OpenGL support:                     Requested:OFF Availability:FALSE Support:FALSE
--
-- Configuring done (63.8s)
-- Generating done (0.7s)
-- Build files have been written to: D:/Dev/Html5/gdalnativeforue/tiff-4.5.1/build
```

这个时候查看build文件夹下，有一个`Makefile`文件了。这个时候执行`emmake make`，输出了正确的日志：
```txt
make: D:\Program Files\mingw64\bin\mingw32-make.EXE
[  0%] Building C object libtiff/CMakeFiles/tiff.dir/tif_aux.c.o
[  1%] Building C object libtiff/CMakeFiles/tiff.dir/tif_close.c.o
[  2%] Building C object libtiff/CMakeFiles/tiff.dir/tif_codec.c.o
[  2%] Building C object libtiff/CMakeFiles/tiff.dir/tif_color.c.o
[  3%] Building C object libtiff/CMakeFiles/tiff.dir/tif_compress.c.o
[  4%] Building C object libtiff/CMakeFiles/tiff.dir/tif_dir.c.o
[  5%] Building C object libtiff/CMakeFiles/tiff.dir/tif_dirinfo.c.o
[  5%] Building C object libtiff/CMakeFiles/tiff.dir/tif_dirread.c.o
[  6%] Building C object libtiff/CMakeFiles/tiff.dir/tif_dirwrite.c.o
[  7%] Building C object libtiff/CMakeFiles/tiff.dir/tif_dumpmode.c.o
[  8%] Building C object libtiff/CMakeFiles/tiff.dir/tif_error.c.o
[  8%] Building C object libtiff/CMakeFiles/tiff.dir/tif_extension.c.o
[  9%] Building C object libtiff/CMakeFiles/tiff.dir/tif_fax3.c.o
[ 10%] Building C object libtiff/CMakeFiles/tiff.dir/tif_fax3sm.c.o
[ 11%] Building C object libtiff/CMakeFiles/tiff.dir/tif_flush.c.o
[ 11%] Building C object libtiff/CMakeFiles/tiff.dir/tif_getimage.c.o
[ 12%] Building C object libtiff/CMakeFiles/tiff.dir/tif_hash_set.c.o
[ 13%] Building C object libtiff/CMakeFiles/tiff.dir/tif_jbig.c.o
[ 14%] Building C object libtiff/CMakeFiles/tiff.dir/tif_jpeg.c.o
[ 14%] Building C object libtiff/CMakeFiles/tiff.dir/tif_jpeg_12.c.o
[ 15%] Building C object libtiff/CMakeFiles/tiff.dir/tif_lerc.c.o
...
```

将curl跳过了，但是得到了一个报错：

```txt
CMake Error at src/apps/CMakeLists.txt:80 (message):
  projsync requires Curl
```

下载了curl源码，其也是cmake工程，emcmake cmake ..配置时又遇到了报错，说没有找到OpenSSL。。

返回来查看proj源码库，其如果开启了`BUILD_APPS`选项，则会开启`BUILD_PROJSYNC`，看了一下，应该只用库不用app，所以这里再次把`BUILD_APPS`选项关了

```cmd
emcmake cmake .. -DCMAKE_INSTALL_PREFIX=D:\Dev\Html5\gdalnativeforue\proj-9.2.1\build\install -DTiff_DIR=D:\Dev\Html5\gdalnativeforue\proj-9.2.1\build\thirdparty\lib\cmake\tiff -DENABLE_CURL=OFF -DBUILD_SHARED_LIBS=OFF -DBUILD_APPS=OFF
```

可以了，不需要curl库了。

现在只剩下一个`CMake Error`：


```txt
-- nlohmann/json: internal
CMake Error at CMakeLists.txt:178 (message):
  sqlite3 binary not found!


CMake Error at CMakeLists.txt:183 (message):
  sqlite3 dependency not found!


CMake Error at CMakeLists.txt:189 (message):
  sqlite3 >= 3.11 required!
```

因为sqlite3源码是Make工程，不是cmake的，我从github找了一个`sqlite3-cmake`工程，其代码量很少，应该移除了一些可执行程序的编译，只产出了一个`libsqlite3.a`，这里需要想办法处理一下了。

查看proj源码，其有一个`FindSqlite3.cmake`，该脚本编写的不太通用，代码如下：
```cmake
find_path(SQLITE3_INCLUDE_DIR sqlite3.h
  "$ENV{LIB_DIR}/include"
  "$ENV{LIB_DIR}/include/sqlite"
  "$ENV{INCLUDE}"
)

find_library(SQLITE3_LIBRARY NAMES sqlite3_i sqlite3 PATHS
  "$ENV{LIB_DIR}/lib"
  "$ENV{LIB}/lib"
)
```

所以这里需要设置一下这几个目录的环境变量
结果：没啥效果，强制修改了`EXE_SQLITE3`，`SQLITE3_INCLUDE_DIR`和`SQLITE3_LIBRARY`。

日志如下：

```shell
make: D:\Program Files\mingw64\bin\mingw32-make.EXE install
-- Requiring C++11
-- Requiring C++11 - done
-- Requiring C99
-- Requiring C99 - done
-- Configuring PROJ:
-- PROJ_VERSION                   = 9.2.1
CMake Deprecation Warning at cmake/Ccache.cmake:10 (cmake_minimum_required):
  Compatibility with CMake < 3.5 will be removed from a future version of
  CMake.

  Update the VERSION argument <min> value or use a ...<max> suffix to tell
  CMake that the project does not need compatibility with older versions.
Call Stack (most recent call first):
  CMakeLists.txt:128 (include)


-- nlohmann/json: internal
-- Configuring proj library:
-- ENABLE_IPO                     = OFF
-- PROJ_CORE_TARGET_OUTPUT_NAME   = proj
-- BUILD_SHARED_LIBS              = OFF
-- PROJ_LIBRARIES                 = proj
-- Could NOT find GTest (missing: GTEST_LIBRARY GTEST_INCLUDE_DIR GTEST_MAIN_LIBRARY) (Required is at least version "1.8.1")
-- Using internal GTest
CMake Deprecation Warning at CMakeLists.txt:2 (cmake_minimum_required):
  Compatibility with CMake < 3.5 will be removed from a future version of
  CMake.

  Update the VERSION argument <min> value or use a ...<max> suffix to tell
  CMake that the project does not need compatibility with older versions.


CMake Warning (dev) at D:/Program Files/CMake/share/cmake-3.30/Modules/ExternalProject/shared_internal_commands.cmake:1284 (message):
  The DOWNLOAD_EXTRACT_TIMESTAMP option was not given and policy CMP0135 is
  not set.  The policy's OLD behavior will be used.  When using a URL
  download, the timestamps of extracted files should preferably be that of
  the time of extraction, otherwise code that depends on the extracted
  contents might not be rebuilt if the URL changes.  The OLD behavior
  preserves the timestamps from the archive instead, but this is usually not
  what you want.  Update your project to the NEW behavior or specify the
  DOWNLOAD_EXTRACT_TIMESTAMP option with a value of true to avoid this
  robustness issue.
Call Stack (most recent call first):
  D:/Program Files/CMake/share/cmake-3.30/Modules/ExternalProject.cmake:3035 (_ep_add_download_command)
  CMakeLists.txt:7 (ExternalProject_Add)
This warning is for project developers.  Use -Wno-dev to suppress it.

-- Configuring done (0.0s)
-- Generating done (0.0s)
-- Build files have been written to: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/googletest-download
mingw32-make.exe[1]: Entering directory 'D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/googletest-download'
mingw32-make.exe[2]: Entering directory 'D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/googletest-download'
mingw32-make.exe[3]: Entering directory 'D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/googletest-download'
mingw32-make.exe[3]: Leaving directory 'D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/googletest-download'
[100%] Built target googletest
mingw32-make.exe[2]: Leaving directory 'D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/googletest-download'
mingw32-make.exe[1]: Leaving directory 'D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/googletest-download'
CMake Deprecation Warning at build/googletest-src/CMakeLists.txt:4 (cmake_minimum_required):
  Compatibility with CMake < 3.5 will be removed from a future version of
  CMake.

  Update the VERSION argument <min> value or use a ...<max> suffix to tell
  CMake that the project does not need compatibility with older versions.


CMake Deprecation Warning at build/googletest-src/googlemock/CMakeLists.txt:45 (cmake_minimum_required):
  Compatibility with CMake < 3.5 will be removed from a future version of
  CMake.

  Update the VERSION argument <min> value or use a ...<max> suffix to tell
  CMake that the project does not need compatibility with older versions.


CMake Deprecation Warning at build/googletest-src/googletest/CMakeLists.txt:56 (cmake_minimum_required):
  Compatibility with CMake < 3.5 will be removed from a future version of
  CMake.

  Update the VERSION argument <min> value or use a ...<max> suffix to tell
  CMake that the project does not need compatibility with older versions.


-- PROJ: Configured 'dist' target
-- Configuring done (1.9s)
-- Generating done (0.4s)
-- Build files have been written to: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build
[  0%] Built target create_tmp_user_writable_dir
[  1%] Generating proj.db
[  1%] Built target generate_proj_db
[  1%] Built target check_wkt1_grammar_md5
[  1%] Built target check_wkt2_grammar_md5
[  1%] Building CXX object src/CMakeFiles/proj.dir/4D_api.cpp.o
[  1%] Building CXX object src/CMakeFiles/proj.dir/aasincos.cpp.o
[  2%] Building CXX object src/CMakeFiles/proj.dir/adjlon.cpp.o
[  2%] Building CXX object src/CMakeFiles/proj.dir/auth.cpp.o
[  2%] Building CXX object src/CMakeFiles/proj.dir/ctx.cpp.o
[  3%] Building CXX object src/CMakeFiles/proj.dir/datum_set.cpp.o
[  3%] Building CXX object src/CMakeFiles/proj.dir/datums.cpp.o
[  4%] Building CXX object src/CMakeFiles/proj.dir/deriv.cpp.o
[  4%] Building CXX object src/CMakeFiles/proj.dir/dmstor.cpp.o
[  4%] Building CXX object src/CMakeFiles/proj.dir/ell_set.cpp.o
[  5%] Building CXX object src/CMakeFiles/proj.dir/ellps.cpp.o
[  5%] Building CXX object src/CMakeFiles/proj.dir/factors.cpp.o
[  5%] Building CXX object src/CMakeFiles/proj.dir/fwd.cpp.o
[  6%] Building CXX object src/CMakeFiles/proj.dir/gauss.cpp.o
[  6%] Building CXX object src/CMakeFiles/proj.dir/generic_inverse.cpp.o
[  7%] Building C object src/CMakeFiles/proj.dir/geodesic.c.o
[  7%] Building CXX object src/CMakeFiles/proj.dir/init.cpp.o
[  7%] Building CXX object src/CMakeFiles/proj.dir/initcache.cpp.o
[  8%] Building CXX object src/CMakeFiles/proj.dir/internal.cpp.o
[  8%] Building CXX object src/CMakeFiles/proj.dir/inv.cpp.o
[  8%] Building CXX object src/CMakeFiles/proj.dir/list.cpp.o
[  9%] Building CXX object src/CMakeFiles/proj.dir/log.cpp.o
[  9%] Building CXX object src/CMakeFiles/proj.dir/malloc.cpp.o
[ 10%] Building CXX object src/CMakeFiles/proj.dir/mlfn.cpp.o
[ 10%] Building CXX object src/CMakeFiles/proj.dir/msfn.cpp.o
[ 10%] Building CXX object src/CMakeFiles/proj.dir/mutex.cpp.o
[ 11%] Building CXX object src/CMakeFiles/proj.dir/param.cpp.o
[ 11%] Building CXX object src/CMakeFiles/proj.dir/phi2.cpp.o
[ 11%] Building CXX object src/CMakeFiles/proj.dir/pipeline.cpp.o
[ 12%] Building CXX object src/CMakeFiles/proj.dir/pr_list.cpp.o
[ 12%] Building CXX object src/CMakeFiles/proj.dir/proj_mdist.cpp.o
[ 13%] Building CXX object src/CMakeFiles/proj.dir/qsfn.cpp.o
[ 13%] Building CXX object src/CMakeFiles/proj.dir/release.cpp.o
[ 13%] Building CXX object src/CMakeFiles/proj.dir/rtodms.cpp.o
[ 14%] Building CXX object src/CMakeFiles/proj.dir/strerrno.cpp.o
[ 14%] Building CXX object src/CMakeFiles/proj.dir/strtod.cpp.o
[ 14%] Building CXX object src/CMakeFiles/proj.dir/tsfn.cpp.o
[ 15%] Building CXX object src/CMakeFiles/proj.dir/units.cpp.o
[ 15%] Building C object src/CMakeFiles/proj.dir/wkt1_generated_parser.c.o
D:\Dev\Html5\gdalnativeforue\proj-9.2.1\src\wkt1_generated_parser.c:1318:9: warning: variable 'pj_wkt1_nerrs' set but not used [-Wunused-but-set-variable]
 1318 |     int yynerrs;
      |         ^
D:\Dev\Html5\gdalnativeforue\proj-9.2.1\src\wkt1_generated_parser.c:71:25: note: expanded from macro 'yynerrs'
   71 | #define yynerrs         pj_wkt1_nerrs
      |                         ^
1 warning generated.
[ 16%] Building CXX object src/CMakeFiles/proj.dir/wkt1_parser.cpp.o
[ 16%] Building C object src/CMakeFiles/proj.dir/wkt2_generated_parser.c.o
D:\Dev\Html5\gdalnativeforue\proj-9.2.1\src\wkt2_generated_parser.c:2885:9: warning: variable 'pj_wkt2_nerrs' set but not used [-Wunused-but-set-variable]
 2885 |     int yynerrs;
      |         ^
D:\Dev\Html5\gdalnativeforue\proj-9.2.1\src\wkt2_generated_parser.c:71:25: note: expanded from macro 'yynerrs'
   71 | #define yynerrs         pj_wkt2_nerrs
      |                         ^
1 warning generated.
[ 16%] Building CXX object src/CMakeFiles/proj.dir/wkt2_parser.cpp.o
[ 17%] Building CXX object src/CMakeFiles/proj.dir/wkt_parser.cpp.o
[ 17%] Building CXX object src/CMakeFiles/proj.dir/zpoly1.cpp.o
[ 17%] Building CXX object src/CMakeFiles/proj.dir/proj_json_streaming_writer.cpp.o
[ 18%] Building CXX object src/CMakeFiles/proj.dir/tracing.cpp.o
[ 18%] Building CXX object src/CMakeFiles/proj.dir/grids.cpp.o
[ 19%] Building CXX object src/CMakeFiles/proj.dir/filemanager.cpp.o
[ 19%] Building CXX object src/CMakeFiles/proj.dir/networkfilemanager.cpp.o
[ 19%] Building CXX object src/CMakeFiles/proj.dir/sqlite3_utils.cpp.o
[ 20%] Building CXX object src/CMakeFiles/proj.dir/conversions/axisswap.cpp.o
[ 20%] Building CXX object src/CMakeFiles/proj.dir/conversions/cart.cpp.o
[ 20%] Building CXX object src/CMakeFiles/proj.dir/conversions/geoc.cpp.o
[ 21%] Building CXX object src/CMakeFiles/proj.dir/conversions/geocent.cpp.o
[ 21%] Building CXX object src/CMakeFiles/proj.dir/conversions/noop.cpp.o
[ 22%] Building CXX object src/CMakeFiles/proj.dir/conversions/topocentric.cpp.o
[ 22%] Building CXX object src/CMakeFiles/proj.dir/conversions/set.cpp.o
[ 22%] Building CXX object src/CMakeFiles/proj.dir/conversions/unitconvert.cpp.o
[ 23%] Building CXX object src/CMakeFiles/proj.dir/projections/aeqd.cpp.o
[ 23%] Building CXX object src/CMakeFiles/proj.dir/projections/adams.cpp.o
[ 23%] Building CXX object src/CMakeFiles/proj.dir/projections/gnom.cpp.o
[ 24%] Building CXX object src/CMakeFiles/proj.dir/projections/laea.cpp.o
[ 24%] Building CXX object src/CMakeFiles/proj.dir/projections/mod_ster.cpp.o
[ 25%] Building CXX object src/CMakeFiles/proj.dir/projections/nsper.cpp.o
[ 25%] Building CXX object src/CMakeFiles/proj.dir/projections/nzmg.cpp.o
[ 25%] Building CXX object src/CMakeFiles/proj.dir/projections/ortho.cpp.o
[ 26%] Building CXX object src/CMakeFiles/proj.dir/projections/stere.cpp.o
[ 26%] Building CXX object src/CMakeFiles/proj.dir/projections/sterea.cpp.o
[ 26%] Building CXX object src/CMakeFiles/proj.dir/projections/aea.cpp.o
[ 27%] Building CXX object src/CMakeFiles/proj.dir/projections/bipc.cpp.o
[ 27%] Building CXX object src/CMakeFiles/proj.dir/projections/bonne.cpp.o
[ 28%] Building CXX object src/CMakeFiles/proj.dir/projections/eqdc.cpp.o
[ 28%] Building CXX object src/CMakeFiles/proj.dir/projections/isea.cpp.o
[ 28%] Building CXX object src/CMakeFiles/proj.dir/projections/ccon.cpp.o
[ 29%] Building CXX object src/CMakeFiles/proj.dir/projections/imw_p.cpp.o
[ 29%] Building CXX object src/CMakeFiles/proj.dir/projections/krovak.cpp.o
[ 29%] Building CXX object src/CMakeFiles/proj.dir/projections/lcc.cpp.o
[ 30%] Building CXX object src/CMakeFiles/proj.dir/projections/poly.cpp.o
[ 30%] Building CXX object src/CMakeFiles/proj.dir/projections/rpoly.cpp.o
[ 31%] Building CXX object src/CMakeFiles/proj.dir/projections/sconics.cpp.o
[ 31%] Building CXX object src/CMakeFiles/proj.dir/projections/rouss.cpp.o
[ 31%] Building CXX object src/CMakeFiles/proj.dir/projections/cass.cpp.o
[ 32%] Building CXX object src/CMakeFiles/proj.dir/projections/cc.cpp.o
[ 32%] Building CXX object src/CMakeFiles/proj.dir/projections/cea.cpp.o
[ 32%] Building CXX object src/CMakeFiles/proj.dir/projections/eqc.cpp.o
[ 33%] Building CXX object src/CMakeFiles/proj.dir/projections/gall.cpp.o
[ 33%] Building CXX object src/CMakeFiles/proj.dir/projections/labrd.cpp.o
[ 34%] Building CXX object src/CMakeFiles/proj.dir/projections/som.cpp.o
[ 34%] Building CXX object src/CMakeFiles/proj.dir/projections/merc.cpp.o
[ 34%] Building CXX object src/CMakeFiles/proj.dir/projections/mill.cpp.o
[ 35%] Building CXX object src/CMakeFiles/proj.dir/projections/ocea.cpp.o
[ 35%] Building CXX object src/CMakeFiles/proj.dir/projections/omerc.cpp.o
[ 35%] Building CXX object src/CMakeFiles/proj.dir/projections/somerc.cpp.o
[ 36%] Building CXX object src/CMakeFiles/proj.dir/projections/tcc.cpp.o
[ 36%] Building CXX object src/CMakeFiles/proj.dir/projections/tcea.cpp.o
[ 37%] Building CXX object src/CMakeFiles/proj.dir/projections/times.cpp.o
[ 37%] Building CXX object src/CMakeFiles/proj.dir/projections/tmerc.cpp.o
[ 37%] Building CXX object src/CMakeFiles/proj.dir/projections/tobmerc.cpp.o
[ 38%] Building CXX object src/CMakeFiles/proj.dir/projections/airy.cpp.o
[ 38%] Building CXX object src/CMakeFiles/proj.dir/projections/aitoff.cpp.o
[ 38%] Building CXX object src/CMakeFiles/proj.dir/projections/august.cpp.o
[ 39%] Building CXX object src/CMakeFiles/proj.dir/projections/bacon.cpp.o
[ 39%] Building CXX object src/CMakeFiles/proj.dir/projections/bertin1953.cpp.o
[ 40%] Building CXX object src/CMakeFiles/proj.dir/projections/chamb.cpp.o
[ 40%] Building CXX object src/CMakeFiles/proj.dir/projections/hammer.cpp.o
[ 40%] Building CXX object src/CMakeFiles/proj.dir/projections/lagrng.cpp.o
[ 41%] Building CXX object src/CMakeFiles/proj.dir/projections/larr.cpp.o
[ 41%] Building CXX object src/CMakeFiles/proj.dir/projections/lask.cpp.o
[ 42%] Building CXX object src/CMakeFiles/proj.dir/projections/latlong.cpp.o
[ 42%] Building CXX object src/CMakeFiles/proj.dir/projections/nicol.cpp.o
[ 42%] Building CXX object src/CMakeFiles/proj.dir/projections/ob_tran.cpp.o
[ 43%] Building CXX object src/CMakeFiles/proj.dir/projections/oea.cpp.o
[ 43%] Building CXX object src/CMakeFiles/proj.dir/projections/tpeqd.cpp.o
[ 43%] Building CXX object src/CMakeFiles/proj.dir/projections/vandg.cpp.o
[ 44%] Building CXX object src/CMakeFiles/proj.dir/projections/vandg2.cpp.o
[ 44%] Building CXX object src/CMakeFiles/proj.dir/projections/vandg4.cpp.o
[ 45%] Building CXX object src/CMakeFiles/proj.dir/projections/wag7.cpp.o
[ 45%] Building CXX object src/CMakeFiles/proj.dir/projections/lcca.cpp.o
[ 45%] Building CXX object src/CMakeFiles/proj.dir/projections/geos.cpp.o
[ 46%] Building CXX object src/CMakeFiles/proj.dir/projections/boggs.cpp.o
[ 46%] Building CXX object src/CMakeFiles/proj.dir/projections/collg.cpp.o
[ 46%] Building CXX object src/CMakeFiles/proj.dir/projections/comill.cpp.o
[ 47%] Building CXX object src/CMakeFiles/proj.dir/projections/crast.cpp.o
[ 47%] Building CXX object src/CMakeFiles/proj.dir/projections/denoy.cpp.o
[ 48%] Building CXX object src/CMakeFiles/proj.dir/projections/eck1.cpp.o
[ 48%] Building CXX object src/CMakeFiles/proj.dir/projections/eck2.cpp.o
[ 48%] Building CXX object src/CMakeFiles/proj.dir/projections/eck3.cpp.o
[ 50%] Building CXX object src/CMakeFiles/proj.dir/projections/eck4.cpp.o
[ 50%] Building CXX object src/CMakeFiles/proj.dir/projections/eck5.cpp.o
[ 50%] Building CXX object src/CMakeFiles/proj.dir/projections/fahey.cpp.o
[ 51%] Building CXX object src/CMakeFiles/proj.dir/projections/fouc_s.cpp.o
[ 51%] Building CXX object src/CMakeFiles/proj.dir/projections/gins8.cpp.o
[ 52%] Building CXX object src/CMakeFiles/proj.dir/projections/gstmerc.cpp.o
[ 52%] Building CXX object src/CMakeFiles/proj.dir/projections/gn_sinu.cpp.o
[ 52%] Building CXX object src/CMakeFiles/proj.dir/projections/goode.cpp.o
[ 53%] Building CXX object src/CMakeFiles/proj.dir/projections/igh.cpp.o
[ 53%] Building CXX object src/CMakeFiles/proj.dir/projections/igh_o.cpp.o
[ 53%] Building CXX object src/CMakeFiles/proj.dir/projections/imoll.cpp.o
[ 54%] Building CXX object src/CMakeFiles/proj.dir/projections/imoll_o.cpp.o
[ 54%] Building CXX object src/CMakeFiles/proj.dir/projections/hatano.cpp.o
[ 55%] Building CXX object src/CMakeFiles/proj.dir/projections/loxim.cpp.o
[ 55%] Building CXX object src/CMakeFiles/proj.dir/projections/mbt_fps.cpp.o
[ 55%] Building CXX object src/CMakeFiles/proj.dir/projections/mbtfpp.cpp.o
[ 56%] Building CXX object src/CMakeFiles/proj.dir/projections/mbtfpq.cpp.o
[ 56%] Building CXX object src/CMakeFiles/proj.dir/projections/moll.cpp.o
[ 56%] Building CXX object src/CMakeFiles/proj.dir/projections/nell.cpp.o
[ 57%] Building CXX object src/CMakeFiles/proj.dir/projections/nell_h.cpp.o
[ 57%] Building CXX object src/CMakeFiles/proj.dir/projections/patterson.cpp.o
[ 58%] Building CXX object src/CMakeFiles/proj.dir/projections/putp2.cpp.o
[ 58%] Building CXX object src/CMakeFiles/proj.dir/projections/putp3.cpp.o
[ 58%] Building CXX object src/CMakeFiles/proj.dir/projections/putp4p.cpp.o
[ 59%] Building CXX object src/CMakeFiles/proj.dir/projections/putp5.cpp.o
[ 59%] Building CXX object src/CMakeFiles/proj.dir/projections/putp6.cpp.o
[ 59%] Building CXX object src/CMakeFiles/proj.dir/projections/qsc.cpp.o
[ 60%] Building CXX object src/CMakeFiles/proj.dir/projections/robin.cpp.o
[ 60%] Building CXX object src/CMakeFiles/proj.dir/projections/s2.cpp.o
[ 61%] Building CXX object src/CMakeFiles/proj.dir/projections/sch.cpp.o
[ 61%] Building CXX object src/CMakeFiles/proj.dir/projections/sts.cpp.o
[ 61%] Building CXX object src/CMakeFiles/proj.dir/projections/urm5.cpp.o
[ 62%] Building CXX object src/CMakeFiles/proj.dir/projections/urmfps.cpp.o
[ 62%] Building CXX object src/CMakeFiles/proj.dir/projections/wag2.cpp.o
[ 62%] Building CXX object src/CMakeFiles/proj.dir/projections/wag3.cpp.o
[ 63%] Building CXX object src/CMakeFiles/proj.dir/projections/wink1.cpp.o
[ 63%] Building CXX object src/CMakeFiles/proj.dir/projections/wink2.cpp.o
[ 64%] Building CXX object src/CMakeFiles/proj.dir/projections/healpix.cpp.o
[ 64%] Building CXX object src/CMakeFiles/proj.dir/projections/natearth.cpp.o
[ 64%] Building CXX object src/CMakeFiles/proj.dir/projections/natearth2.cpp.o
[ 65%] Building CXX object src/CMakeFiles/proj.dir/projections/calcofi.cpp.o
[ 65%] Building CXX object src/CMakeFiles/proj.dir/projections/eqearth.cpp.o
[ 65%] Building CXX object src/CMakeFiles/proj.dir/projections/col_urban.cpp.o
[ 66%] Building CXX object src/CMakeFiles/proj.dir/transformations/affine.cpp.o
[ 66%] Building CXX object src/CMakeFiles/proj.dir/transformations/deformation.cpp.o
[ 67%] Building CXX object src/CMakeFiles/proj.dir/transformations/gridshift.cpp.o
[ 67%] Building CXX object src/CMakeFiles/proj.dir/transformations/helmert.cpp.o
[ 67%] Building CXX object src/CMakeFiles/proj.dir/transformations/hgridshift.cpp.o
[ 68%] Building CXX object src/CMakeFiles/proj.dir/transformations/horner.cpp.o
[ 68%] Building CXX object src/CMakeFiles/proj.dir/transformations/molodensky.cpp.o
[ 68%] Building CXX object src/CMakeFiles/proj.dir/transformations/vgridshift.cpp.o
[ 69%] Building CXX object src/CMakeFiles/proj.dir/transformations/xyzgridshift.cpp.o
[ 69%] Building CXX object src/CMakeFiles/proj.dir/transformations/defmodel.cpp.o
[ 70%] Building CXX object src/CMakeFiles/proj.dir/transformations/tinshift.cpp.o
[ 70%] Building CXX object src/CMakeFiles/proj.dir/transformations/vertoffset.cpp.o
[ 70%] Building CXX object src/CMakeFiles/proj.dir/iso19111/static.cpp.o
[ 71%] Building CXX object src/CMakeFiles/proj.dir/iso19111/util.cpp.o
[ 71%] Building CXX object src/CMakeFiles/proj.dir/iso19111/metadata.cpp.o
[ 71%] Building CXX object src/CMakeFiles/proj.dir/iso19111/common.cpp.o
[ 72%] Building CXX object src/CMakeFiles/proj.dir/iso19111/coordinates.cpp.o
[ 72%] Building CXX object src/CMakeFiles/proj.dir/iso19111/crs.cpp.o
[ 73%] Building CXX object src/CMakeFiles/proj.dir/iso19111/datum.cpp.o
[ 73%] Building CXX object src/CMakeFiles/proj.dir/iso19111/coordinatesystem.cpp.o
[ 73%] Building CXX object src/CMakeFiles/proj.dir/iso19111/io.cpp.o
[ 74%] Building CXX object src/CMakeFiles/proj.dir/iso19111/internal.cpp.o
[ 74%] Building CXX object src/CMakeFiles/proj.dir/iso19111/factory.cpp.o
[ 74%] Building CXX object src/CMakeFiles/proj.dir/iso19111/c_api.cpp.o
[ 75%] Building CXX object src/CMakeFiles/proj.dir/iso19111/operation/concatenatedoperation.cpp.o
[ 75%] Building CXX object src/CMakeFiles/proj.dir/iso19111/operation/coordinateoperationfactory.cpp.o
[ 76%] Building CXX object src/CMakeFiles/proj.dir/iso19111/operation/conversion.cpp.o
[ 76%] Building CXX object src/CMakeFiles/proj.dir/iso19111/operation/esriparammappings.cpp.o
[ 76%] Building CXX object src/CMakeFiles/proj.dir/iso19111/operation/oputils.cpp.o
[ 77%] Building CXX object src/CMakeFiles/proj.dir/iso19111/operation/parammappings.cpp.o
[ 77%] Building CXX object src/CMakeFiles/proj.dir/iso19111/operation/projbasedoperation.cpp.o
[ 77%] Building CXX object src/CMakeFiles/proj.dir/iso19111/operation/singleoperation.cpp.o
[ 78%] Building CXX object src/CMakeFiles/proj.dir/iso19111/operation/transformation.cpp.o
[ 78%] Building CXX object src/CMakeFiles/proj.dir/iso19111/operation/vectorofvaluesparams.cpp.o
[ 79%] Linking CXX static library ..\lib\libproj.a
[ 79%] Built target proj
[ 80%] Building CXX object src/apps/CMakeFiles/gie.dir/gie.cpp.o
[ 80%] Building CXX object src/apps/CMakeFiles/gie.dir/proj_strtod.cpp.o
[ 80%] Linking CXX executable ..\..\bin\gie.js
cache:INFO: generating system library: sysroot\lib\wasm32-emscripten\libstubs.a... (this will be cached in "D:\Dev\UE-HTML5-4.27\Engine\Platforms\HTML5\Build\emsdk\emsdk-3.1.56\upstream\emscripten\cache\sysroot\lib\wasm32-emscripten\libstubs.a" for subsequent builds)
system_libs:INFO: compiled 2 inputs in 0.35s
cache:INFO:  - ok
cache:INFO: generating system library: sysroot\lib\wasm32-emscripten\libc.a... (this will be cached in "D:\Dev\UE-HTML5-4.27\Engine\Platforms\HTML5\Build\emsdk\emsdk-3.1.56\upstream\emscripten\cache\sysroot\lib\wasm32-emscripten\libc.a" for subsequent builds)
system_libs:INFO: compiled 1026 inputs in 23.35s
cache:INFO:  - ok
cache:INFO: generating system library: sysroot\lib\wasm32-emscripten\libc++abi-noexcept.a... (this will be cached in "D:\Dev\UE-HTML5-4.27\Engine\Platforms\HTML5\Build\emsdk\emsdk-3.1.56\upstream\emscripten\cache\sysroot\lib\wasm32-emscripten\libc++abi-noexcept.a" for subsequent builds)
system_libs:INFO: compiled 16 inputs in 2.40s
cache:INFO:  - ok
cache:INFO: generating system asset: symbol_lists/141dd8c626a3df5de47b82a31371cd3db8dc4533.json... (this will be cached in "D:\Dev\UE-HTML5-4.27\Engine\Platforms\HTML5\Build\emsdk\emsdk-3.1.56\upstream\emscripten\cache\symbol_lists\141dd8c626a3df5de47b82a31371cd3db8dc4533.json" for subsequent builds)
cache:INFO:  - ok
[ 80%] Built target gie
[ 81%] Building C object src/tests/CMakeFiles/geodtest.dir/geodtest.c.o
[ 81%] Linking CXX executable ..\..\bin\geodtest.js
[ 81%] Built target geodtest
[ 81%] Building C object src/tests/CMakeFiles/geodsigntest.dir/geodsigntest.c.o
[ 81%] Linking C executable ..\..\bin\geodsigntest.js
[ 81%] Built target geodsigntest
[ 81%] Building CXX object googletest-build/googletest/CMakeFiles/gtest.dir/src/gtest-all.cc.o
[ 82%] Linking CXX static library ..\..\lib\libgtest.a
[ 82%] Built target gtest
[ 82%] Building CXX object test/unit/CMakeFiles/proj_errno_string_test.dir/main.cpp.o
[ 83%] Building CXX object test/unit/CMakeFiles/proj_errno_string_test.dir/proj_errno_string_test.cpp.o
[ 83%] Linking CXX executable ..\..\bin\proj_errno_string_test.js
[ 83%] Built target proj_errno_string_test
[ 83%] Building CXX object test/unit/CMakeFiles/proj_angular_io_test.dir/main.cpp.o
[ 83%] Building CXX object test/unit/CMakeFiles/proj_angular_io_test.dir/proj_angular_io_test.cpp.o
[ 84%] Linking CXX executable ..\..\bin\proj_angular_io_test.js
[ 84%] Built target proj_angular_io_test
[ 84%] Building CXX object test/unit/CMakeFiles/proj_context_test.dir/main.cpp.o
[ 84%] Building CXX object test/unit/CMakeFiles/proj_context_test.dir/proj_context_test.cpp.o
[ 85%] Linking CXX executable ..\..\bin\proj_context_test.js
[ 85%] Built target proj_context_test
[ 86%] Building CXX object test/unit/CMakeFiles/pj_phi2_test.dir/main.cpp.o
[ 86%] Building CXX object test/unit/CMakeFiles/pj_phi2_test.dir/pj_phi2_test.cpp.o
[ 87%] Linking CXX executable ..\..\bin\pj_phi2_test.js
[ 87%] Built target pj_phi2_test
[ 87%] Building CXX object test/unit/CMakeFiles/proj_test_cpp_api.dir/main.cpp.o
[ 88%] Building CXX object test/unit/CMakeFiles/proj_test_cpp_api.dir/test_util.cpp.o
[ 88%] Building CXX object test/unit/CMakeFiles/proj_test_cpp_api.dir/test_common.cpp.o
[ 88%] Building CXX object test/unit/CMakeFiles/proj_test_cpp_api.dir/test_coordinates.cpp.o
[ 89%] Building CXX object test/unit/CMakeFiles/proj_test_cpp_api.dir/test_crs.cpp.o
[ 89%] Building CXX object test/unit/CMakeFiles/proj_test_cpp_api.dir/test_metadata.cpp.o
[ 90%] Building CXX object test/unit/CMakeFiles/proj_test_cpp_api.dir/test_io.cpp.o
[ 90%] Building CXX object test/unit/CMakeFiles/proj_test_cpp_api.dir/test_operation.cpp.o
[ 90%] Building CXX object test/unit/CMakeFiles/proj_test_cpp_api.dir/test_operationfactory.cpp.o
[ 91%] Building CXX object test/unit/CMakeFiles/proj_test_cpp_api.dir/test_datum.cpp.o
[ 91%] Building CXX object test/unit/CMakeFiles/proj_test_cpp_api.dir/test_factory.cpp.o
[ 91%] Building CXX object test/unit/CMakeFiles/proj_test_cpp_api.dir/test_c_api.cpp.o
[ 92%] Building CXX object test/unit/CMakeFiles/proj_test_cpp_api.dir/test_grids.cpp.o
[ 92%] Linking CXX executable ..\..\bin\proj_test_cpp_api.js
[ 92%] Built target proj_test_cpp_api
[ 93%] Building CXX object test/unit/CMakeFiles/gie_self_tests.dir/main.cpp.o
[ 93%] Building CXX object test/unit/CMakeFiles/gie_self_tests.dir/gie_self_tests.cpp.o
[ 93%] Linking CXX executable ..\..\bin\gie_self_tests.js
[ 93%] Built target gie_self_tests
[ 94%] Building CXX object test/unit/CMakeFiles/test_network.dir/main.cpp.o
[ 94%] Building CXX object test/unit/CMakeFiles/test_network.dir/test_network.cpp.o
[ 94%] Linking CXX executable ..\..\bin\test_network.js
[ 94%] Built target test_network
[ 95%] Building CXX object test/unit/CMakeFiles/test_defmodel.dir/main.cpp.o
[ 95%] Building CXX object test/unit/CMakeFiles/test_defmodel.dir/test_defmodel.cpp.o
[ 95%] Linking CXX executable ..\..\bin\test_defmodel.js
[ 95%] Built target test_defmodel
[ 96%] Building CXX object test/unit/CMakeFiles/test_tinshift.dir/main.cpp.o
[ 96%] Building CXX object test/unit/CMakeFiles/test_tinshift.dir/test_tinshift.cpp.o
[ 97%] Linking CXX executable ..\..\bin\test_tinshift.js
[ 97%] Built target test_tinshift
[ 97%] Building CXX object test/unit/CMakeFiles/test_misc.dir/main.cpp.o
[ 98%] Building CXX object test/unit/CMakeFiles/test_misc.dir/test_misc.cpp.o
[ 98%] Linking CXX executable ..\..\bin\test_misc.js
[ 98%] Built target test_misc
[100%] Building C object test/unit/CMakeFiles/test_fork.dir/test_fork.c.o
[100%] Linking CXX executable ..\..\bin\test_fork.js
[100%] Built target test_fork
[100%] Building CXX object test/benchmark/CMakeFiles/bench_proj_trans.dir/bench_proj_trans.cpp.o
[100%] Linking CXX executable ..\..\bin\bench_proj_trans.js
[100%] Built target bench_proj_trans
Install the project...
-- Install configuration: "Release"
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/share/doc/proj/COPYING
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/share/doc/proj/NEWS
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/share/doc/proj/AUTHORS
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/lib/pkgconfig/proj.pc
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/share/proj/proj.ini
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/share/proj/world
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/share/proj/other.extra
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/share/proj/nad27
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/share/proj/GL27
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/share/proj/nad83
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/share/proj/nad.lst
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/share/proj/CH
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/share/proj/ITRF2000
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/share/proj/ITRF2008
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/share/proj/ITRF2014
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/share/proj/proj.db
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/share/proj/deformation_model.schema.json
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/share/proj/projjson.schema.json
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/share/proj/triangulation.schema.json
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/include/proj/util.hpp
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/include/proj/metadata.hpp
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/include/proj/common.hpp
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/include/proj/coordinates.hpp
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/include/proj/crs.hpp
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/include/proj/datum.hpp
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/include/proj/coordinatesystem.hpp
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/include/proj/coordinateoperation.hpp
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/include/proj/io.hpp
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/include/proj/nn.hpp
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/lib/libproj.a
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/include/proj.h
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/include/proj_experimental.h
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/include/proj_constants.h
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/include/proj_symbol_rename.h
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/include/geodesic.h
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/share/man/man1/proj.1
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/share/man/man1/cs2cs.1
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/share/man/man1/geod.1
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/share/man/man1/cct.1
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/share/man/man1/gie.1
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/share/man/man1/projinfo.1
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/share/man/man1/projsync.1
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/lib/cmake/proj/proj-config.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/lib/cmake/proj/proj-config-version.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/lib/cmake/proj/proj-targets.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/lib/cmake/proj/proj-targets-release.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/lib/cmake/proj/proj4-targets.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/lib/cmake/proj/proj4-targets-release.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/lib/cmake/proj4/proj4-config.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/lib/cmake/proj4/proj4-config-version.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/lib/cmake/proj4/proj-targets.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/lib/cmake/proj4/proj-targets-release.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/lib/cmake/proj4/proj4-targets.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/proj-9.2.1/build/install/lib/cmake/proj4/proj4-targets-release.cmake
```

最后一步，编译gdal库
报错了，又说找不到`Could NOT find PROJ`，查找源码，发现`FindPROJ.cmake`，其写法如下：
```cmake

find_path(PROJ_INCLUDE_DIR proj.h
          PATHS ${PROJ_ROOT}/include
          DOC "Path to PROJ library include directory")

set(PROJ_NAMES ${PROJ_NAMES} proj proj_i)
set(PROJ_NAMES_DEBUG ${PROJ_NAMES_DEBUG} projd proj_d)

if(NOT PROJ_LIBRARY)
  find_library(PROJ_LIBRARY_RELEASE NAMES ${PROJ_NAMES})
  find_library(PROJ_LIBRARY_DEBUG NAMES ${PROJ_NAMES_DEBUG})
  include(SelectLibraryConfigurations)
  select_library_configurations(PROJ)
  mark_as_advanced(PROJ_LIBRARY_RELEASE PROJ_LIBRARY_DEBUG)
endif()
```

可以看到使用的变量是`PROJ_ROOT`，最终使用了如下命令：
```shell
emcmake cmake .. -DCMAKE_INSTALL_PREFIX=D:\Dev\Html5\gdalnativeforue\gdal-3.7.0\build\install -DCMAKE_PREFIX_PATH=D:\Dev\Html5\gdalnativeforue\gdal-3.7.0\build\thirdparty -DPROJ_ROOT=D:\Dev\Html5\gdalnativeforue\gdal-3.7.0\build\thirdparty -DPROJ_LIBRARY=D:\Dev\Html5\gdalnativeforue\gdal-3.7.0\build\thirdparty\lib\libproj.a -DPROJ_INCLUDE_DIR=D:\Dev\Html5\gdalnativeforue\gdal-3.7.0\build\thirdparty\include
```

链接阶段失败了，gdal库报了`libproj.a(grids.cpp.o)`，找不到`TIFFXXXXXX`，将proj使用的tiff库也拷贝到gdal的thirdparty中，添加命令参数，最终如下：
```shell
emcmake cmake .. -DCMAKE_INSTALL_PREFIX=D:\Dev\Html5\gdalnativeforue\gdal-3.7.0\build\install -DCMAKE_PREFIX_PATH=D:\Dev\Html5\gdalnativeforue\gdal-3.7.0\build\thirdparty -DPROJ_ROOT=D:\Dev\Html5\gdalnativeforue\gdal-3.7.0\build\thirdparty -DPROJ_LIBRARY=D:\Dev\Html5\gdalnativeforue\gdal-3.7.0\build\thirdparty\lib\libproj.a -DPROJ_INCLUDE_DIR=D:\Dev\Html5\gdalnativeforue\gdal-3.7.0\build\thirdparty\include -DTiff_DIR=D:\Dev\Html5\gdalnativeforue\gdal-3.7.0\build\thirdparty\lib\cmake\tiff
```

再次尝试emmake make install
还是不行，分析了，原因是`gdal_libtiff_symbol_rename.h`搞的鬼，其又被cmake的编译选项`RENAME_INTERNAL_TIFF_SYMBOLS`控制了，将其关闭，链接时没有报TIFF的错了，新的出来了，sqlite3

最新的编译gdal的命令：
```shell
emcmake cmake .. -DCMAKE_INSTALL_PREFIX=D:\Dev\Html5\gdalnativeforue\gdal-3.7.0\build\install -DCMAKE_PREFIX_PATH=D:\Dev\Html5\gdalnativeforue\gdal-3.7.0\build\thirdparty -DPROJ_ROOT=D:\Dev\Html5\gdalnativeforue\gdal-3.7.0\build\thirdparty -DPROJ_LIBRARY=D:\Dev\Html5\gdalnativeforue\gdal-3.7.0\build\thirdparty\lib\libproj.a -DPROJ_INCLUDE_DIR=D:\Dev\Html5\gdalnativeforue\gdal-3.7.0\build\thirdparty\include -DTiff_DIR=D:\Dev\Html5\gdalnativeforue\gdal-3.7.0\build\thirdparty\lib\cmake\tiff -DRENAME_INTERNAL_TIFF_SYMBOLS=OFF
```



```shell
wasm-ld: error: ../thirdparty/lib/libproj.a(networkfilemanager.cpp.o): undefined symbol: sqlite3_open_v2
wasm-ld: error: ../thirdparty/lib/libproj.a(networkfilemanager.cpp.o): undefined symbol: sqlite3_exec
wasm-ld: error: ../thirdparty/lib/libproj.a(networkfilemanager.cpp.o): undefined symbol: sqlite3_errmsg
wasm-ld: error: ../thirdparty/lib/libproj.a(networkfilemanager.cpp.o): undefined symbol: sqlite3_close
wasm-ld: error: ../thirdparty/lib/libproj.a(networkfilemanager.cpp.o): undefined symbol: sqlite3_close
wasm-ld: error: ../thirdparty/lib/libproj.a(networkfilemanager.cpp.o): undefined symbol: sqlite3_get_table
wasm-ld: error: ../thirdparty/lib/libproj.a(networkfilemanager.cpp.o): undefined symbol: sqlite3_free_table
wasm-ld: error: ../thirdparty/lib/libproj.a(networkfilemanager.cpp.o): undefined symbol: sqlite3_exec
wasm-ld: error: ../thirdparty/lib/libproj.a(networkfilemanager.cpp.o): undefined symbol: sqlite3_errmsg
wasm-ld: error: ../thirdparty/lib/libproj.a(networkfilemanager.cpp.o): undefined symbol: sqlite3_close
wasm-ld: error: ../thirdparty/lib/libproj.a(networkfilemanager.cpp.o): undefined symbol: sqlite3_exec
wasm-ld: error: ../thirdparty/lib/libproj.a(networkfilemanager.cpp.o): undefined symbol: sqlite3_errmsg
wasm-ld: error: ../thirdparty/lib/libproj.a(networkfilemanager.cpp.o): undefined symbol: sqlite3_close
wasm-ld: error: ../thirdparty/lib/libproj.a(networkfilemanager.cpp.o): undefined symbol: sqlite3_prepare_v2
wasm-ld: error: ../thirdparty/lib/libproj.a(networkfilemanager.cpp.o): undefined symbol: sqlite3_errmsg
wasm-ld: error: ../thirdparty/lib/libproj.a(networkfilemanager.cpp.o): undefined symbol: sqlite3_step
wasm-ld: error: ../thirdparty/lib/libproj.a(networkfilemanager.cpp.o): undefined symbol: sqlite3_prepare_v2
wasm-ld: error: ../thirdparty/lib/libproj.a(networkfilemanager.cpp.o): undefined symbol: sqlite3_errmsg
wasm-ld: error: ../thirdparty/lib/libproj.a(networkfilemanager.cpp.o): undefined symbol: sqlite3_finalize
wasm-ld: error: ../thirdparty/lib/libproj.a(networkfilemanager.cpp.o): undefined symbol: sqlite3_step
```

查看proj源码的`networkfilemanager.cpp`，有sqlite3_xx接口的调用，然后该文件有如下的代码：
```cpp
#ifdef CURL_ENABLED
#include <curl/curl.h>
#include <sqlite3.h> // for sqlite3_snprintf
#endif
```

我在之前编译的时候，禁用了CURL，所以推测是这里导致的问题。但是，其之前包含了`sqlite3_utils.hpp`，该文件中又包含了`sqlite3.h`，所以应该不是这里的问题。。

查看了proj依赖sqlite3库的cmake代码，其设置如下：
```cmake
target_include_directories(proj PRIVATE ${SQLITE3_INCLUDE_DIR})
target_link_libraries(proj PRIVATE ${SQLITE3_LIBRARY})
```

根据依赖的私有性原则，gdal在依赖proj库时，将无法正确链接到sqlite3，这里将库的PRIVATE改为PUBLIC，即：
```cmake
target_include_directories(proj PRIVATE ${SQLITE3_INCLUDE_DIR})
target_link_libraries(proj PUBLIC ${SQLITE3_LIBRARY})
```
再次尝试编译

依然不行，这下查看gdal源码，发现其中有很多依赖sqlite3库的代码，但是我在configure阶段，得到的日志是`Could Not find SQLite3`，和之前同理，强制设置`SQLite3_INCLUDE_DIR`和`SQLite3_LIBRARY`路径，再次configure，这次找到SQLite3的依赖了，日志如下：

```shell
-- Importing target "TIFF::tiff"
-- Could NOT find SWIG (missing: SWIG_EXECUTABLE SWIG_DIR)
-- Could NOT find Python (missing: Python_INCLUDE_DIRS Python_LIBRARIES Python_NumPy_INCLUDE_DIRS Development NumPy Development.Module Development.Embed) (found suitable version "3.12.2", minimum required is "3.6")
-- checking if sprintf can be overloaded for GDAL compilation
-- GDAL_VERSION          = 3.7.0
-- GDAL_ABI_FULL_VERSION = 33.3.7.0
-- GDAL_SOVERSION        = 33
-- Could NOT find ODBC (missing: ODBC_LIBRARY ODBC_INCLUDE_DIR ODBCINST)
-- Could NOT find ODBCCPP (missing: ODBCCPP_LIBRARY ODBCCPP_INCLUDE_DIR)
-- Could NOT find MSSQL_ODBC (missing: MSSQL_ODBC_LIBRARY MSSQL_ODBC_INCLUDE_DIR MSSQL_ODBC_VERSION)
-- Could NOT find MySQL (missing: MYSQL_LIBRARY MYSQL_INCLUDE_DIR)
-- Could NOT find CURL (missing: CURL_LIBRARY CURL_INCLUDE_DIR)
-- Could NOT find LibXml2 (missing: LIBXML2_LIBRARY LIBXML2_INCLUDE_DIR)
-- Could NOT find EXPAT (missing: EXPAT_DIR)
-- Could NOT find EXPAT (missing: EXPAT_LIBRARY EXPAT_INCLUDE_DIR)
-- Failed to find XercesC (missing: XercesC_LIBRARY XercesC_INCLUDE_DIR XercesC_VERSION)
-- Could NOT find ZLIB (missing: ZLIB_LIBRARY ZLIB_INCLUDE_DIR)
-- Could NOT find Deflate (missing: Deflate_LIBRARY Deflate_INCLUDE_DIR)
-- Could NOT find OpenSSL, try to set the path to OpenSSL root folder in the system variable OPENSSL_ROOT_DIR (missing: OPENSSL_CRYPTO_LIBRARY OPENSSL_INCLUDE_DIR SSL Crypto)
-- Could NOT find CryptoPP (missing: CRYPTOPP_LIBRARY CRYPTOPP_TEST_KNOWNBUG CRYPTOPP_INCLUDE_DIR)
-- Could NOT find ZSTD (missing: ZSTD_DIR)
-- Could NOT find PkgConfig (missing: PKG_CONFIG_EXECUTABLE)
-- Could NOT find ZSTD (missing: ZSTD_LIBRARY ZSTD_INCLUDE_DIR)
-- Could NOT find SFCGAL (missing: SFCGAL_LIBRARY SFCGAL_INCLUDE_DIR)
-- Could NOT find GeoTIFF (missing: GeoTIFF_DIR)
-- Could NOT find GeoTIFF (missing: GEOTIFF_LIBRARY GEOTIFF_INCLUDE_DIR)
-- Could NOT find ZLIB (missing: ZLIB_LIBRARY ZLIB_INCLUDE_DIR)
-- Could NOT find PNG (missing: PNG_LIBRARY PNG_PNG_INCLUDE_DIR)
-- Could NOT find JPEG (missing: JPEG_LIBRARY JPEG_INCLUDE_DIR)
-- Could NOT find GIF (missing: GIF_LIBRARY GIF_INCLUDE_DIR)
-- Could NOT find JSONC (missing: JSONC_DIR)
-- Could NOT find JSONC (missing: JSONC_LIBRARY JSONC_INCLUDE_DIR)
-- Could NOT find OpenCAD (missing: OPENCAD_LIBRARY OPENCAD_INCLUDE_DIR)
-- Could NOT find QHULL (missing: QHULL_LIBRARY QHULL_INCLUDE_DIR)
-- Could NOT find LERC (missing: LERC_LIBRARY LERC_INCLUDE_DIR)
-- Could NOT find BRUNSLI (missing: BRUNSLI_ENC_LIB BRUNSLI_DEC_LIB BRUNSLI_INCLUDE_DIR)
-- Could NOT find libQB3 (missing: libQB3_DIR)
-- Could NOT find Shapelib (missing: Shapelib_INCLUDE_DIR Shapelib_LIBRARY)
-- Could NOT find PCRE2 (missing: PCRE2-8_LIBRARY PCRE2_INCLUDE_DIR)
-- Could NOT find PCRE (missing: PCRE_LIBRARY PCRE_INCLUDE_DIR)
-- Looking for sqlite3_open
-- Looking for sqlite3_open - found
-- Looking for sqlite3_mutex_alloc
-- Looking for sqlite3_mutex_alloc - found
-- Looking for sqlite3_column_table_name
-- Looking for sqlite3_column_table_name - not found
-- Looking for sqlite3_rtree_query_callback
-- Looking for sqlite3_rtree_query_callback - found
-- Looking for sqlite3_load_extension
-- Looking for sqlite3_load_extension - found
-- Looking for sqlite3_progress_handler
-- Looking for sqlite3_progress_handler - found
-- Performing Test SQLite3_HAS_NON_DEPRECATED_AUTO_EXTENSION
-- Performing Test SQLite3_HAS_NON_DEPRECATED_AUTO_EXTENSION - Success
...
```

再次尝试进行make install。Nice！，make install 成功！日志如下：

```shell
...
[ 94%] Built target gcore
[ 94%] Linking CXX static library libgdal.a
[ 94%] Built target GDAL
[ 94%] Built target check_swq_parser_md5
[ 94%] Linking CXX executable gdalinfo.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[ 94%] Built target gdalinfo
[ 94%] Building CXX object apps/CMakeFiles/gdalbuildvrt.dir/gdalbuildvrt_bin.cpp.o
[ 94%] Linking CXX executable gdalbuildvrt.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[ 94%] Built target gdalbuildvrt
[ 94%] Building CXX object apps/CMakeFiles/gdaladdo.dir/gdaladdo.cpp.o
[ 94%] Linking CXX executable gdaladdo.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[ 94%] Built target gdaladdo
[ 95%] Building CXX object apps/CMakeFiles/gdal_grid.dir/gdal_grid_bin.cpp.o
[ 95%] Linking CXX executable gdal_grid.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[ 95%] Built target gdal_grid
[ 95%] Building CXX object apps/CMakeFiles/gdal_translate.dir/gdal_translate_bin.cpp.o
[ 95%] Linking CXX executable gdal_translate.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[ 95%] Built target gdal_translate
[ 95%] Building CXX object apps/CMakeFiles/gdalwarp.dir/gdalwarp_bin.cpp.o
[ 95%] Linking CXX executable gdalwarp.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[ 95%] Built target gdalwarp
[ 95%] Building CXX object apps/CMakeFiles/gdal_contour.dir/gdal_contour.cpp.o
[ 95%] Linking CXX executable gdal_contour.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[ 95%] Built target gdal_contour
[ 95%] Building CXX object apps/CMakeFiles/gdalenhance.dir/gdalenhance.cpp.o
[ 95%] Linking CXX executable gdalenhance.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[ 95%] Built target gdalenhance
[ 95%] Building CXX object apps/CMakeFiles/gdallocationinfo.dir/gdallocationinfo.cpp.o
[ 95%] Linking CXX executable gdallocationinfo.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[ 95%] Built target gdallocationinfo
[ 96%] Building CXX object apps/CMakeFiles/gdalmanage.dir/gdalmanage.cpp.o
[ 96%] Linking CXX executable gdalmanage.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[ 96%] Built target gdalmanage
[ 96%] Building CXX object apps/CMakeFiles/gdalsrsinfo.dir/gdalsrsinfo.cpp.o
[ 96%] Linking CXX executable gdalsrsinfo.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[ 96%] Built target gdalsrsinfo
[ 96%] Building CXX object apps/CMakeFiles/gdaltindex.dir/gdaltindex.cpp.o
[ 96%] Linking CXX executable gdaltindex.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[ 96%] Built target gdaltindex
[ 96%] Building CXX object apps/CMakeFiles/gdal_rasterize.dir/gdal_rasterize_bin.cpp.o
[ 96%] Linking CXX executable gdal_rasterize.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[ 96%] Built target gdal_rasterize
[ 96%] Building CXX object apps/CMakeFiles/gdaldem.dir/gdaldem_bin.cpp.o
[ 96%] Linking CXX executable gdaldem.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[ 96%] Built target gdaldem
[ 96%] Building CXX object apps/CMakeFiles/gdaltransform.dir/gdaltransform.cpp.o
[ 97%] Linking CXX executable gdaltransform.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[ 97%] Built target gdaltransform
[ 97%] Building CXX object apps/CMakeFiles/gdal_create.dir/gdal_create.cpp.o
[ 97%] Linking CXX executable gdal_create.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[ 97%] Built target gdal_create
[ 97%] Building CXX object apps/CMakeFiles/gdal_viewshed.dir/gdal_viewshed.cpp.o
[ 97%] Linking CXX executable gdal_viewshed.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[ 97%] Built target gdal_viewshed
[ 97%] Building CXX object apps/CMakeFiles/ogrinfo.dir/ogrinfo_bin.cpp.o
[ 97%] Linking CXX executable ogrinfo.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[ 97%] Built target ogrinfo
[ 97%] Building CXX object apps/CMakeFiles/ogr2ogr.dir/ogr2ogr_bin.cpp.o
[ 97%] Linking CXX executable ogr2ogr.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[ 97%] Built target ogr2ogr
[ 97%] Building CXX object apps/CMakeFiles/ogrlineref.dir/ogrlineref.cpp.o
[ 98%] Linking CXX executable ogrlineref.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[ 98%] Built target ogrlineref
[ 98%] Building CXX object apps/CMakeFiles/ogrtindex.dir/ogrtindex.cpp.o
[ 98%] Linking CXX executable ogrtindex.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[ 98%] Built target ogrtindex
[ 98%] Building CXX object apps/CMakeFiles/nearblack.dir/nearblack_bin.cpp.o
[ 98%] Linking CXX executable nearblack.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[ 98%] Built target nearblack
[ 98%] Building CXX object apps/CMakeFiles/gdalmdiminfo.dir/gdalmdiminfo_bin.cpp.o
[ 98%] Linking CXX executable gdalmdiminfo.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[ 98%] Built target gdalmdiminfo
[ 98%] Building CXX object apps/CMakeFiles/gdalmdimtranslate.dir/gdalmdimtranslate_bin.cpp.o
[ 98%] Linking CXX executable gdalmdimtranslate.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[ 98%] Built target gdalmdimtranslate
[ 98%] Building CXX object apps/CMakeFiles/sozip.dir/sozip.cpp.o
[ 98%] Linking CXX executable sozip.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[ 98%] Built target sozip
[100%] Building CXX object apps/CMakeFiles/gnmanalyse.dir/gnmanalyse.cpp.o
[100%] Linking CXX executable gnmanalyse.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[100%] Built target gnmanalyse
[100%] Building CXX object apps/CMakeFiles/gnmmanage.dir/gnmmanage.cpp.o
[100%] Linking CXX executable gnmmanage.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[100%] Built target gnmmanage
[100%] Building CXX object apps/CMakeFiles/test_ogrsf.dir/test_ogrsf.cpp.o
[100%] Linking CXX executable test_ogrsf.js
wasm-ld: warning: function signature mismatch: gdal_crc32_combine
>>> defined as (i32, i32, i64) -> i32 in ../libgdal.a(cpl_vsil_gzip.cpp.o)
>>> defined as (i32, i32, i32) -> i32 in ../libgdal.a(crc32.c.o)
[100%] Built target test_ogrsf
Install the project...
-- Install configuration: ""
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/gdalinfo.js
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/gdalbuildvrt.js
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/gdaladdo.js
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/gdal_grid.js
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/gdal_translate.js
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/gdal_rasterize.js
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/gdalsrsinfo.js
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/gdalenhance.js
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/gdalmanage.js
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/gdaltransform.js
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/gdaltindex.js
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/gdaldem.js
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/gdal_create.js
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/gdal_viewshed.js
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/nearblack.js
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/ogrlineref.js
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/ogrtindex.js
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/gdalwarp.js
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/gdal_contour.js
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/gdallocationinfo.js
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/ogrinfo.js
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/ogr2ogr.js
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/gdalmdiminfo.js
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/gdalmdimtranslate.js
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/sozip.js
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/gnmanalyse.js
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/gnmmanage.js
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdalinfo
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdal2tiles.py
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdal2xyz.py
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdaladdo
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdalbuildvrt
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdal_calc.py
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdalchksum.py
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdalcompare.py
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdal-config
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdal_contour
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdaldem
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdal_edit.py
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdalenhance
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdal_fillnodata.py
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdal_grid
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdalident.py
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdalimport.py
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdallocationinfo
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdalmanage
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdal_merge.py
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdalmove.py
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdal_polygonize.py
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdal_proximity.py
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdal_rasterize
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdal_retile.py
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdal_sieve.py
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdalsrsinfo
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdaltindex
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdaltransform
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdal_translate
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdalwarp
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/ogr2ogr
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/ogrinfo
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/ogrlineref
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/ogrmerge.py
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/ogrtindex
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdal_viewshed
-- Installing D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/bash-completion/completions/gdal_create
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdal-config.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdal2tiles.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdaladdo.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdalbuildvrt.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdalcompare.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdaldem.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdalinfo.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdallocationinfo.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdalmanage.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdalmdiminfo.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdalmdimtranslate.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdalmove.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdalsrsinfo.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdaltindex.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdaltransform.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdalwarp.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdal_calc.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdal_contour.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdal_create.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdal_edit.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdal_fillnodata.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdal_grid.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdal_merge.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdal_pansharpen.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdal_polygonize.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdal_proximity.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdal_rasterize.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdal_retile.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdal_sieve.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdal_translate.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gdal_viewshed.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gnmanalyse.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/gnmmanage.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/nearblack.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/ogr2ogr.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/ogrinfo.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/ogrlineref.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/ogrmerge.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/ogrtindex.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/ogr_layer_algebra.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/pct2rgb.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/rgb2pct.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/man/man1/sozip.1
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/gdalplugins/drivers.ini
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/libgdal.a
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cpl_atomic_ops.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cpl_auto_close.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cpl_compressor.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cpl_config_extras.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cpl_conv.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cpl_csv.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cpl_error.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cpl_hash_set.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cpl_http.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cpl_json.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cplkeywordparser.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cpl_list.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cpl_minixml.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cpl_multiproc.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cpl_port.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cpl_progress.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cpl_quad_tree.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cpl_spawn.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cpl_string.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cpl_time.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cpl_vsi.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cpl_vsi_error.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cpl_vsi_virtual.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cpl_virtualmem.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/gdal_csv.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cpl_minizip_ioapi.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cpl_minizip_unzip.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cpl_minizip_zip.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/gdal_alg.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/gdal_alg_priv.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/gdalgrid.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/gdalgrid_priv.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/gdalwarper.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/gdal_simplesurf.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/gdalpansharpen.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/ogr_api.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/ogr_recordbatch.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/ogr_core.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/ogr_feature.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/ogr_featurestyle.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/ogr_geocoding.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/ogr_geometry.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/ogr_p.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/ogr_spatialref.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/ogr_swq.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/ogr_srs_api.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/ogrsf_frmts.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/gnm.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/gnm_api.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/gnmgraph.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/memdataset.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/vrtdataset.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/gdal_vrt.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/gdal_version.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/gdal.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/gdaljp2metadata.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/gdaljp2abstractdataset.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/gdal_frmts.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/gdal_pam.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/gdal_priv.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/gdal_proxy.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/gdal_rat.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/gdalcachedpixelaccessor.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/rawdataset.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/gdalgeorefpamdataset.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/gdal_mdreader.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/gdal_utils.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/include/cpl_config.h
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/LICENSE.TXT
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/GDALLogoBW.svg
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/GDALLogoColor.svg
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/GDALLogoGS.svg
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/bag_template.xml
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/cubewerx_extra.wkt
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/default.rsc
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/ecw_cs.wkt
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/eedaconf.json
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/epsg.wkt
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/esri_StatePlane_extra.wkt
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/gdalicon.png
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/gdalinfo_output.schema.json
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/gdalmdiminfo_output.schema.json
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/gdalvrt.xsd
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/gml_registry.xml
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/gmlasconf.xml
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/gmlasconf.xsd
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_versions.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_center.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_process.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_subcenter.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_0_0.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_0_13.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_0_14.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_0_15.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_0_16.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_0_17.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_0_18.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_0_190.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_0_191.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_0_19.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_0_1.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_0_20.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_0_21.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_0_2.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_0_3.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_0_4.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_0_5.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_0_6.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_0_7.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_10_0.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_10_191.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_10_1.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_10_2.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_10_3.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_10_4.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_1_0.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_1_1.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_1_2.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_20_0.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_20_1.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_20_2.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_2_0.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_2_3.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_2_4.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_2_5.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_2_6.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_3_0.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_3_1.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_3_2.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_3_3.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_3_4.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_3_5.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_3_6.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_4_0.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_4_10.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_4_1.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_4_2.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_4_3.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_4_4.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_4_5.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_4_6.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_4_7.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_4_8.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_4_9.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_local_Canada.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_local_HPC.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_local_index.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_local_MRMS.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_local_NCEP.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_2_local_NDFD.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/grib2_table_4_5.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/gt_datum.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/gt_ellips.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/header.dxf
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/inspire_cp_BasicPropertyUnit.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/inspire_cp_CadastralBoundary.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/inspire_cp_CadastralParcel.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/inspire_cp_CadastralZoning.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/jpfgdgml_AdmArea.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/jpfgdgml_AdmBdry.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/jpfgdgml_AdmPt.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/jpfgdgml_BldA.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/jpfgdgml_BldL.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/jpfgdgml_Cntr.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/jpfgdgml_CommBdry.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/jpfgdgml_CommPt.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/jpfgdgml_Cstline.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/jpfgdgml_ElevPt.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/jpfgdgml_GCP.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/jpfgdgml_LeveeEdge.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/jpfgdgml_RailCL.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/jpfgdgml_RdASL.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/jpfgdgml_RdArea.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/jpfgdgml_RdCompt.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/jpfgdgml_RdEdg.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/jpfgdgml_RdMgtBdry.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/jpfgdgml_RdSgmtA.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/jpfgdgml_RvrMgtBdry.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/jpfgdgml_SBAPt.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/jpfgdgml_SBArea.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/jpfgdgml_SBBdry.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/jpfgdgml_WA.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/jpfgdgml_WL.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/jpfgdgml_WStrA.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/jpfgdgml_WStrL.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/netcdf_config.xsd
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/nitf_spec.xml
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/nitf_spec.xsd
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/ogrvrt.xsd
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/osmconf.ini
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/ogrinfo_output.schema.json
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/ozi_datum.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/ozi_ellips.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/pci_datum.txt
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/pci_ellips.txt
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/pdfcomposition.xsd
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/pds4_template.xml
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/plscenesconf.json
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/ruian_vf_ob_v1.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/ruian_vf_st_uvoh_v1.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/ruian_vf_st_v1.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/ruian_vf_v1.gfs
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/s57agencies.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/s57attributes.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/s57expectedinput.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/s57objectclasses.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/seed_2d.dgn
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/seed_3d.dgn
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/stateplane.csv
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/template_tiles.mapml
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/tms_LINZAntarticaMapTileGrid.json
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/tms_MapML_APSTILE.json
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/tms_MapML_CBMTILE.json
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/tms_NZTM2000.json
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/trailer.dxf
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/vdv452.xml
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/vdv452.xsd
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/share/gdal/vicar.json
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/GDAL-targets.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/GDAL-targets-noconfig.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/GdalFindModulePath.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/DefineFindPackage2.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/3.20
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/3.20/FindLibLZMA.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/3.20/FindPostgreSQL.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/3.16
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/3.16/FindPython
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/3.16/FindPython/ListExt.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/3.16/FindPython/Support.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/3.16/FindPython.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/3.16/FindPython2.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/3.16/FindPython3.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/3.14
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/3.14/FindCURL.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/3.13
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/3.13/FindXercesC.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/3.12
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/3.12/FindBoost.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/3.12/FindEXPAT.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/3.12/FindJPEG.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/3.12/FindLibXml2.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/3.12/FindOpenSSL.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/3.12/FindPNG.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindBlosc.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindBRUNSLI.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindCryptoPP.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindDB2.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindDeflate.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindECW.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindFileGDB.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindFreeXL.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindFYBA.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindGEOS.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindGeoTIFF.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindGIF.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindHDF4.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindHDFS.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindIconv.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindIDB.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindJSONC.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindKDU.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindLERC.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindLibKML.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindLURATECH.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindLZ4.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindMONGOCXX.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindMRSID.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindMSSQL_NCLI.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindMSSQL_ODBC.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindMySQL.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindNetCDF.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindODBC.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindODBCCPP.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindOGDI.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindOpenCAD.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindOpenEXR.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindOpenJPEG.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindOracle.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindPCRE.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindPCRE2.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindPodofo.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindPoppler.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindPROJ.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindQHULL.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindRASTERLITE2.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindSFCGAL.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindShapelib.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindSpatialindex.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindSPATIALITE.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindSQLite3.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindTEIGHA.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindWebP.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/packages/FindZSTD.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/thirdparty
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/thirdparty/DotnetImports.props.in
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/thirdparty/FindCSharp.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/thirdparty/FindDotnet.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/thirdparty/FindInt128.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/thirdparty/FindMono.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/thirdparty/GetGitHeadDate.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/thirdparty/GetGitRevisionDescription.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/thirdparty/GetGitRevisionDescription.cmake.in
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/thirdparty/OSXInstallDirs.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/thirdparty/SystemSummary.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/GDALConfigVersion.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/cmake/gdal/GDALConfig.cmake
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/bin/gdal-config
-- Installing: D:/Dev/Html5/gdalnativeforue/gdal-3.7.0/build/install/lib/pkgconfig/gdal.pc
```

