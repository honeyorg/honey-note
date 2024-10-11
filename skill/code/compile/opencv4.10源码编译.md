#cross-compilation #build #opencv #ffmpeg

[源码仓库](https://github.com/opencv/opencv/tree/4.10.0)
[官方文档](https://docs.opencv.org/4.10.0/)

[[opencv库交叉编译踩坑]]


现需要对opencv源码进行编译，目标是编译成动态库，支持windows和linux平台，且编译时要开启ffmpeg选项，将ffmpeg集成进来。后续使用ffmpeg对视频流的音频部分进行处理。

源码拉取下来，因源码工程是cmake的，故使用vscode老帮手进行配置编译

初次打开工程，还未进行分支切换，编译器选择了`msvc-2022-amd64-ninja`，得到的配置信息如下：
```shell
[main] 正在配置项目: opencv

[proc] 执行命令: "D:/Program Files/Microsoft Visual Studio/2022/Professional/Common7/IDE/CommonExtensions/Microsoft/CMake/CMake/bin/cmake.exe" -DCMAKE_BUILD_TYPE:STRING=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE --no-warn-unused-cli -SD:/Dev/OtherGit/opencv -Bd:/Dev/OtherGit/opencv/build -G Ninja

[cmake] Not searching for unused variables given on the command line.

[cmake] -- The CXX compiler identification is MSVC 19.37.32822.0

[cmake] -- The C compiler identification is MSVC 19.37.32822.0

[cmake] -- Detecting CXX compiler ABI info

[cmake] -- Detecting CXX compiler ABI info - done

[cmake] -- Check for working CXX compiler: D:/Program Files/Microsoft Visual Studio/2022/Professional/VC/Tools/MSVC/14.37.32822/bin/Hostx64/x64/cl.exe - skipped

[cmake] -- Detecting CXX compile features

[cmake] -- Detecting CXX compile features - done

[cmake] -- Detecting C compiler ABI info

[cmake] -- Detecting C compiler ABI info - done

[cmake] -- Check for working C compiler: D:/Program Files/Microsoft Visual Studio/2022/Professional/VC/Tools/MSVC/14.37.32822/bin/Hostx64/x64/cl.exe - skipped

[cmake] -- Detecting C compile features

[cmake] -- Detecting C compile features - done

[cmake] -- Detected processor: AMD64

[cmake] -- Found PythonInterp: D:/Program Files/Python312/python.exe (found suitable version "3.12.2", minimum required is "3.2")

[cmake] -- Found PythonLibs: optimized;D:/Program Files/Python312/libs/python312.lib;debug;D:/Program Files/Python312/libs/python312_d.lib (found suitable exact version "3.12.2")

[cmake] Traceback (most recent call last):

[cmake]   File "<string>", line 1, in <module>

[cmake] ModuleNotFoundError: No module named 'numpy'

[cmake] -- Performing Test HAVE_CXX_FP:PRECISE

[cmake] -- Performing Test HAVE_CXX_FP:PRECISE - Success

[cmake] -- Performing Test HAVE_C_FP:PRECISE

[cmake] -- Performing Test HAVE_C_FP:PRECISE - Success

[cmake] -- Performing Test HAVE_CPU_SSE3_SUPPORT (check file: cmake/checks/cpu_sse3.cpp)

[cmake] -- Performing Test HAVE_CPU_SSE3_SUPPORT - Success

[cmake] -- Performing Test HAVE_CPU_SSSE3_SUPPORT (check file: cmake/checks/cpu_ssse3.cpp)

[cmake] -- Performing Test HAVE_CPU_SSSE3_SUPPORT - Success

[cmake] -- Performing Test HAVE_CPU_SSE4_1_SUPPORT (check file: cmake/checks/cpu_sse41.cpp)

[cmake] -- Performing Test HAVE_CPU_SSE4_1_SUPPORT - Success

[cmake] -- Performing Test HAVE_CPU_POPCNT_SUPPORT (check file: cmake/checks/cpu_popcnt.cpp)

[cmake] -- Performing Test HAVE_CPU_POPCNT_SUPPORT - Success

[cmake] -- Performing Test HAVE_CPU_SSE4_2_SUPPORT (check file: cmake/checks/cpu_sse42.cpp)

[cmake] -- Performing Test HAVE_CPU_SSE4_2_SUPPORT - Success

[cmake] -- Performing Test HAVE_CXX_ARCH:AVX (check file: cmake/checks/cpu_avx.cpp)

[cmake] -- Performing Test HAVE_CXX_ARCH:AVX - Success

[cmake] -- Performing Test HAVE_CXX_ARCH:AVX2 (check file: cmake/checks/cpu_avx2.cpp)

[cmake] -- Performing Test HAVE_CXX_ARCH:AVX2 - Success

[cmake] -- Performing Test HAVE_CXX_ARCH:AVX512 (check file: cmake/checks/cpu_avx512.cpp)

[cmake] -- Performing Test HAVE_CXX_ARCH:AVX512 - Success

[cmake] -- Performing Test HAVE_CPU_BASELINE_FLAGS

[cmake] -- Performing Test HAVE_CPU_BASELINE_FLAGS - Success

[cmake] -- Performing Test HAVE_CPU_DISPATCH_FLAGS_SSE4_1

[cmake] -- Performing Test HAVE_CPU_DISPATCH_FLAGS_SSE4_1 - Success

[cmake] -- Performing Test HAVE_CPU_DISPATCH_FLAGS_SSE4_2

[cmake] -- Performing Test HAVE_CPU_DISPATCH_FLAGS_SSE4_2 - Success

[cmake] -- Performing Test HAVE_CPU_DISPATCH_FLAGS_AVX

[cmake] -- Performing Test HAVE_CPU_DISPATCH_FLAGS_AVX - Success

[cmake] -- Performing Test HAVE_CPU_DISPATCH_FLAGS_FP16

[cmake] -- Performing Test HAVE_CPU_DISPATCH_FLAGS_FP16 - Success

[cmake] -- Performing Test HAVE_CPU_DISPATCH_FLAGS_AVX2

[cmake] -- Performing Test HAVE_CPU_DISPATCH_FLAGS_AVX2 - Success

[cmake] -- Performing Test HAVE_CPU_DISPATCH_FLAGS_AVX512_SKX

[cmake] -- Performing Test HAVE_CPU_DISPATCH_FLAGS_AVX512_SKX - Success

[cmake] -- Performing Test HAVE_CXX_W15240

[cmake] -- Performing Test HAVE_CXX_W15240 - Success

[cmake] -- Performing Test HAVE_C_W15240

[cmake] -- Performing Test HAVE_C_W15240 - Success

[cmake] -- Looking for malloc.h

[cmake] -- Looking for malloc.h - found

[cmake] -- Looking for _aligned_malloc

[cmake] -- Looking for _aligned_malloc - found

[cmake] -- Looking for fseeko

[cmake] -- Looking for fseeko - not found

[cmake] -- Looking for sys/types.h

[cmake] -- Looking for sys/types.h - found

[cmake] -- Looking for stdint.h

[cmake] -- Looking for stdint.h - found

[cmake] -- Looking for stddef.h

[cmake] -- Looking for stddef.h - found

[cmake] -- Check size of off64_t

[cmake] -- Check size of off64_t - failed

[cmake] -- libjpeg-turbo: VERSION = 3.0.3, BUILD = opencv-4.10.0-dev-libjpeg-turbo-debug

[cmake] -- Check size of size_t

[cmake] -- Check size of size_t - done

[cmake] -- Check size of unsigned long

[cmake] -- Check size of unsigned long - done

[cmake] -- Looking for include file intrin.h

[cmake] -- Looking for include file intrin.h - found

[cmake] -- Looking for a ASM_NASM compiler

[cmake] -- Looking for a ASM_NASM compiler - NOTFOUND

[cmake] -- SIMD extensions disabled: could not find NASM compiler.  Performance will suffer.

[cmake] -- Looking for assert.h

[cmake] -- Looking for assert.h - found

[cmake] -- Looking for fcntl.h

[cmake] -- Looking for fcntl.h - found

[cmake] -- Looking for inttypes.h

[cmake] -- Looking for inttypes.h - found

[cmake] -- Looking for io.h

[cmake] -- Looking for io.h - found

[cmake] -- Looking for limits.h

[cmake] -- Looking for limits.h - found

[cmake] -- Looking for memory.h

[cmake] -- Looking for memory.h - found

[cmake] -- Looking for search.h

[cmake] -- Looking for search.h - found

[cmake] -- Looking for string.h

[cmake] -- Looking for string.h - found

[cmake] -- Performing Test C_HAS_inline

[cmake] -- Performing Test C_HAS_inline - Success

[cmake] -- Check size of signed short

[cmake] -- Check size of signed short - done

[cmake] -- Check size of unsigned short

[cmake] -- Check size of unsigned short - done

[cmake] -- Check size of signed int

[cmake] -- Check size of signed int - done

[cmake] -- Check size of unsigned int

[cmake] -- Check size of unsigned int - done

[cmake] -- Check size of signed long

[cmake] -- Check size of signed long - done

[cmake] -- Check size of unsigned long

[cmake] -- Check size of unsigned long - done

[cmake] -- Check size of signed long long

[cmake] -- Check size of signed long long - done

[cmake] -- Check size of unsigned long long

[cmake] -- Check size of unsigned long long - done

[cmake] -- Check size of unsigned char *

[cmake] -- Check size of unsigned char * - done

[cmake] -- Check size of size_t

[cmake] -- Check size of size_t - done

[cmake] -- Check size of ptrdiff_t

[cmake] -- Check size of ptrdiff_t - done

[cmake] -- Looking for memmove

[cmake] -- Looking for memmove - not found

[cmake] -- Looking for setmode

[cmake] -- Looking for setmode - found

[cmake] -- Looking for strcasecmp

[cmake] -- Looking for strcasecmp - not found

[cmake] -- Looking for strchr

[cmake] -- Looking for strchr - found

[cmake] -- Looking for strrchr

[cmake] -- Looking for strrchr - found

[cmake] -- Looking for strstr

[cmake] -- Looking for strstr - found

[cmake] -- Looking for strtol

[cmake] -- Looking for strtol - found

[cmake] -- Looking for strtol

[cmake] -- Looking for strtol - found

[cmake] -- Looking for strtoull

[cmake] -- Looking for strtoull - found

[cmake] -- Looking for lfind

[cmake] -- Looking for lfind - found

[cmake] -- Could NOT find OpenJPEG (minimal suitable version: 2.0, recommended version >= 2.3.1). OpenJPEG will be built from sources

[cmake] -- OpenJPEG: VERSION = 2.5.0, BUILD = opencv-4.10.0-dev-openjp2-2.5.0-debug

[cmake] -- Looking for stdlib.h

[cmake] -- Looking for stdlib.h - found

[cmake] -- Looking for stdio.h

[cmake] -- Looking for stdio.h - found

[cmake] -- Looking for math.h

[cmake] -- Looking for math.h - found

[cmake] -- Looking for float.h

[cmake] -- Looking for float.h - found

[cmake] -- Looking for time.h

[cmake] -- Looking for time.h - found

[cmake] -- Looking for stdarg.h

[cmake] -- Looking for stdarg.h - found

[cmake] -- Looking for ctype.h

[cmake] -- Looking for ctype.h - found

[cmake] -- Looking for stdint.h

[cmake] -- Looking for stdint.h - found

[cmake] -- Looking for inttypes.h

[cmake] -- Looking for inttypes.h - found

[cmake] -- Looking for strings.h

[cmake] -- Looking for strings.h - not found

[cmake] -- Looking for sys/stat.h

[cmake] -- Looking for sys/stat.h - found

[cmake] -- Looking for unistd.h

[cmake] -- Looking for unistd.h - not found

[cmake] -- Looking for include file malloc.h

[cmake] -- Looking for include file malloc.h - found

[cmake] -- Looking for _aligned_malloc

[cmake] -- Looking for _aligned_malloc - found

[cmake] -- Looking for posix_memalign

[cmake] -- Looking for posix_memalign - not found

[cmake] -- Looking for memalign

[cmake] -- Looking for memalign - not found

[cmake] -- OpenJPEG libraries will be built from sources: libopenjp2 (version "2.5.0")

[cmake] -- IPPICV: Downloading ippicv_2021.12.0_win_intel64_20240425_general.zip from https://raw.githubusercontent.com/opencv/opencv_3rdparty/7f55c0c26be418d494615afca15218566775c725/ippicv/ippicv_2021.12.0_win_intel64_20240425_general.zip

[cmake] -- found Intel IPP (ICV version): 2021.12.0 [2021.12.0]

[cmake] -- at: D:/Dev/OtherGit/opencv/build/3rdparty/ippicv/ippicv_win/icv

[cmake] -- found Intel IPP Integration Wrappers sources: 2021.12.0

[cmake] -- at: D:/Dev/OtherGit/opencv/build/3rdparty/ippicv/ippicv_win/iw

[cmake] -- Could not find OpenBLAS include. Turning OpenBLAS_FOUND off

[cmake] -- Could not find OpenBLAS lib. Turning OpenBLAS_FOUND off

[cmake] -- Looking for sgemm_

[cmake] -- Looking for sgemm_ - not found

[cmake] -- Found Threads: TRUE  

[cmake] -- Could NOT find BLAS (missing: BLAS_LIBRARIES)

[cmake] -- Could NOT find LAPACK (missing: LAPACK_LIBRARIES)

[cmake]     Reason given by package: LAPACK could not be found because dependency BLAS could not be found.

[cmake]

[cmake] -- Found Java: D:/Program Files/Java/jdk1.8.0_181/bin/java.exe (found version "1.8.0.181")

[cmake] -- Found JNI: D:/Program Files/Java/jdk1.8.0_181/include  found components: AWT JVM

[cmake] -- VTK is not found. Please set -DVTK_DIR in CMake to VTK build directory, or to VTK install subdirectory with VTKConfig.cmake file

[cmake] -- ADE: Downloading v0.1.2d.zip from https://github.com/opencv/ade/archive/v0.1.2d.zip

[cmake] -- FFMPEG: Downloading opencv_videoio_ffmpeg.dll from https://raw.githubusercontent.com/opencv/opencv_3rdparty/394dca6ceb3085c979415e6385996b6570e94153/ffmpeg/opencv_videoio_ffmpeg.dll

[cmake] -- FFMPEG: Downloading opencv_videoio_ffmpeg_64.dll from https://raw.githubusercontent.com/opencv/opencv_3rdparty/394dca6ceb3085c979415e6385996b6570e94153/ffmpeg/opencv_videoio_ffmpeg_64.dll

[cmake] -- FFMPEG: Downloading ffmpeg_version.cmake from https://raw.githubusercontent.com/opencv/opencv_3rdparty/394dca6ceb3085c979415e6385996b6570e94153/ffmpeg/ffmpeg_version.cmake

[cmake] -- Looking for mfapi.h

[cmake] -- Looking for mfapi.h - found

[cmake] -- Looking for vidcap.h

[cmake] -- Looking for vidcap.h - found

[cmake] -- Looking for d3d11_4.h

[cmake] -- Looking for d3d11_4.h - found

[cmake] -- Allocator metrics storage type: 'long long'

[cmake] -- Excluding from source files list: <BUILD>/modules/core/test/test_intrin256.lasx.cpp

[cmake] -- Excluding from source files list: modules/imgproc/src/imgwarp.lasx.cpp

[cmake] -- Excluding from source files list: modules/imgproc/src/resize.lasx.cpp

[cmake] -- Registering hook 'INIT_MODULE_SOURCES_opencv_dnn': D:/Dev/OtherGit/opencv/modules/dnn/cmake/hooks/INIT_MODULE_SOURCES_opencv_dnn.cmake

[cmake] -- opencv_dnn: filter out cuda4dnn source code

[cmake] -- Excluding from source files list: modules/dnn/src/layers/cpu_kernels/conv_winograd_f63.neon.cpp

[cmake] -- Excluding from source files list: <BUILD>/modules/dnn/layers/layers_common.rvv.cpp

[cmake] -- Excluding from source files list: <BUILD>/modules/dnn/layers/layers_common.lasx.cpp

[cmake] -- Excluding from source files list: <BUILD>/modules/dnn/int8layers/layers_common.rvv.cpp

[cmake] -- Excluding from source files list: <BUILD>/modules/dnn/int8layers/layers_common.lasx.cpp

[cmake] -- Excluding from source files list: <BUILD>/modules/dnn/layers/cpu_kernels/conv_block.neon.cpp

[cmake] -- Excluding from source files list: <BUILD>/modules/dnn/layers/cpu_kernels/conv_block.neon_fp16.cpp

[cmake] -- Excluding from source files list: <BUILD>/modules/dnn/layers/cpu_kernels/conv_depthwise.rvv.cpp

[cmake] -- Excluding from source files list: <BUILD>/modules/dnn/layers/cpu_kernels/conv_depthwise.lasx.cpp

[cmake] -- Excluding from source files list: <BUILD>/modules/dnn/layers/cpu_kernels/conv_winograd_f63.neon_fp16.cpp

[cmake] -- Excluding from source files list: <BUILD>/modules/dnn/layers/cpu_kernels/fast_gemm_kernels.neon.cpp

[cmake] -- Excluding from source files list: <BUILD>/modules/dnn/layers/cpu_kernels/fast_gemm_kernels.lasx.cpp

[cmake] -- imgcodecs: OpenEXR codec is disabled in runtime. Details: https://github.com/opencv/opencv/issues/21326

[cmake] -- highgui: using builtin backend: WIN32UI

[cmake] -- Use autogenerated whitelist D:/Dev/OtherGit/opencv/build/modules/js_bindings_generator/whitelist.json

[cmake] -- Found 'misc' Python modules from D:/Dev/OtherGit/opencv/modules/python/package/extra_modules

[cmake] -- Found 'mat_wrapper;utils' Python modules from D:/Dev/OtherGit/opencv/modules/core/misc/python/package

[cmake] -- Found 'gapi' Python modules from D:/Dev/OtherGit/opencv/modules/gapi/misc/python/package

[cmake] --

[cmake] -- General configuration for OpenCV 4.10.0-dev =====================================

[cmake] --   Version control:               4.10.0-317-g0f234209da

[cmake] --

[cmake] --   Platform:

[cmake] --     Timestamp:                   2024-10-11T07:56:33Z

[cmake] --     Host:                        Windows 10.0.19045 AMD64

[cmake] --     CMake:                       3.26.4-msvc4

[cmake] --     CMake generator:             Ninja

[cmake] --     CMake build tool:            D:/Program Files/ninja/ninja.exe

[cmake] --     MSVC:                        1937

[cmake] --     Configuration:               Debug

[cmake] --     Algorithm Hint:              ALGO_HINT_ACCURATE

[cmake] --

[cmake] --   CPU/HW features:

[cmake] --     Baseline:                    SSE SSE2 SSE3

[cmake] --       requested:                 SSE3

[cmake] --     Dispatched code generation:  SSE4_1 SSE4_2 AVX FP16 AVX2 AVX512_SKX

[cmake] --       SSE4_1 (18 files):         + SSSE3 SSE4_1

[cmake] --       SSE4_2 (2 files):          + SSSE3 SSE4_1 POPCNT SSE4_2

[cmake] --       AVX (9 files):             + SSSE3 SSE4_1 POPCNT SSE4_2 AVX

[cmake] --       FP16 (1 files):            + SSSE3 SSE4_1 POPCNT SSE4_2 AVX FP16

[cmake] --       AVX2 (38 files):           + SSSE3 SSE4_1 POPCNT SSE4_2 AVX FP16 AVX2 FMA3

[cmake] --       AVX512_SKX (8 files):      + SSSE3 SSE4_1 POPCNT SSE4_2 AVX FP16 AVX2 FMA3 AVX_512F AVX512_COMMON AVX512_SKX

[cmake] --

[cmake] --   C/C++:

[cmake] --     Built as dynamic libs?:      YES

[cmake] --     C++ standard:                11

[cmake] --     C++ Compiler:                D:/Program Files/Microsoft Visual Studio/2022/Professional/VC/Tools/MSVC/14.37.32822/bin/Hostx64/x64/cl.exe  (ver 19.37.32822.0)

[cmake] --     C++ flags (Release):         /DWIN32 /D_WINDOWS /W4 /GR  /D _CRT_SECURE_NO_DEPRECATE /D _CRT_NONSTDC_NO_DEPRECATE /D _SCL_SECURE_NO_WARNINGS /Gy /bigobj /Oi  /fp:precise /FS    /EHa /wd4127 /wd4251 /wd4324 /wd4275 /wd4512 /wd4589 /wd4819  /O2 /Ob2 /DNDEBUG

[cmake] --     C++ flags (Debug):           /DWIN32 /D_WINDOWS /W4 /GR  /D _CRT_SECURE_NO_DEPRECATE /D _CRT_NONSTDC_NO_DEPRECATE /D _SCL_SECURE_NO_WARNINGS /Gy /bigobj /Oi  /fp:precise /FS    /EHa /wd4127 /wd4251 /wd4324 /wd4275 /wd4512 /wd4589 /wd4819  /Zi /Ob0 /Od /RTC1

[cmake] --     C Compiler:                  D:/Program Files/Microsoft Visual Studio/2022/Professional/VC/Tools/MSVC/14.37.32822/bin/Hostx64/x64/cl.exe

[cmake] --     C flags (Release):           /DWIN32 /D_WINDOWS /W3  /D _CRT_SECURE_NO_DEPRECATE /D _CRT_NONSTDC_NO_DEPRECATE /D _SCL_SECURE_NO_WARNINGS /Gy /bigobj /Oi  /fp:precise /FS      /O2 /Ob2 /DNDEBUG

[cmake] --     C flags (Debug):             /DWIN32 /D_WINDOWS /W3  /D _CRT_SECURE_NO_DEPRECATE /D _CRT_NONSTDC_NO_DEPRECATE /D _SCL_SECURE_NO_WARNINGS /Gy /bigobj /Oi  /fp:precise /FS    /Zi /Ob0 /Od /RTC1

[cmake] --     Linker flags (Release):      /machine:x64  /INCREMENTAL:NO

[cmake] --     Linker flags (Debug):        /machine:x64  /debug /INCREMENTAL

[cmake] --     ccache:                      NO

[cmake] --     Precompiled headers:         NO

[cmake] --     Extra dependencies:

[cmake] --     3rdparty dependencies:

[cmake] --

[cmake] --   OpenCV modules:

[cmake] --     To be built:                 calib3d core dnn features2d flann gapi highgui imgcodecs imgproc java ml objdetect photo stitching ts video videoio

[cmake] --     Disabled:                    world

[cmake] --     Disabled by dependency:      -

[cmake] --     Unavailable:                 python2 python3

[cmake] --     Applications:                tests perf_tests apps

[cmake] --     Documentation:               NO

[cmake] --     Non-free algorithms:         NO

[cmake] --

[cmake] --   Windows RT support:            NO

[cmake] --

[cmake] --   GUI:                           WIN32UI

[cmake] --     Win32 UI:                    YES

[cmake] --     VTK support:                 NO

[cmake] --

[cmake] --   Media I/O:

[cmake] --     ZLib:                        build (ver 1.3.1)

[cmake] --     JPEG:                        build-libjpeg-turbo (ver 3.0.3-70)

[cmake] --       SIMD Support Request:      YES

[cmake] --       SIMD Support:              NO

[cmake] --     WEBP:                        build (ver encoder: 0x020f)

[cmake] --     PNG:                         build (ver 1.6.43)

[cmake] --       SIMD Support Request:      YES

[cmake] --       SIMD Support:              YES (Intel SSE)

[cmake] --     TIFF:                        build (ver 42 - 4.6.0)

[cmake] --     JPEG 2000:                   build (ver 2.5.0)

[cmake] --     OpenEXR:                     build (ver 2.3.0)

[cmake] --     HDR:                         YES

[cmake] --     SUNRASTER:                   YES

[cmake] --     PXM:                         YES

[cmake] --     PFM:                         YES

[cmake] --

[cmake] --   Video I/O:

[cmake] --     FFMPEG:                      YES (prebuilt binaries)

[cmake] --       avcodec:                   YES (58.134.100)

[cmake] --       avformat:                  YES (58.76.100)

[cmake] --       avutil:                    YES (56.70.100)

[cmake] --       swscale:                   YES (5.9.100)

[cmake] --       avresample:                YES (4.0.0)

[cmake] --     GStreamer:                   NO

[cmake] --     DirectShow:                  YES

[cmake] --     Media Foundation:            YES

[cmake] --       DXVA:                      YES

[cmake] --

[cmake] --   Parallel framework:            Concurrency

[cmake] --

[cmake] --   Trace:                         YES (with Intel ITT)

[cmake] --

[cmake] --   Other third-party libraries:

[cmake] --     Intel IPP:                   2021.12.0 [2021.12.0]

[cmake] --            at:                   D:/Dev/OtherGit/opencv/build/3rdparty/ippicv/ippicv_win/icv

[cmake] --     Intel IPP IW:                sources (2021.12.0)

[cmake] --               at:                D:/Dev/OtherGit/opencv/build/3rdparty/ippicv/ippicv_win/iw

[cmake] --     Lapack:                      NO

[cmake] --     Eigen:                       NO

[cmake] --     Custom HAL:                  NO

[cmake] --     Protobuf:                    build (3.19.1)

[cmake] --     Flatbuffers:                 builtin/3rdparty (23.5.9)

[cmake] --

[cmake] --   OpenCL:                        YES (NVD3D11)

[cmake] --     Include path:                D:/Dev/OtherGit/opencv/3rdparty/include/opencl/1.2

[cmake] --     Link libraries:              Dynamic load

[cmake] --

[cmake] --   Python (for build):            D:/Program Files/Python312/python.exe

[cmake] --

[cmake] --   Java:                          

[cmake] --     ant:                         NO

[cmake] --     Java:                        YES (ver 1.8.0.181)

[cmake] --     JNI:                         D:/Program Files/Java/jdk1.8.0_181/include D:/Program Files/Java/jdk1.8.0_181/include/win32 D:/Program Files/Java/jdk1.8.0_181/include

[cmake] --     Java wrappers:               YES (JAVA)

[cmake] --     Java tests:                  NO

[cmake] --

[cmake] --   Install to:                    D:/Dev/OtherGit/opencv/build/install

[cmake] -- -----------------------------------------------------------------

[cmake] --

[cmake] -- Configuring done (53.0s)

[cmake] -- Generating done (0.6s)

[cmake] -- Build files have been written to: D:/Dev/OtherGit/opencv/build

[main] 正在配置项目: opencv

[proc] 执行命令: "D:/Program Files/Microsoft Visual Studio/2022/Professional/Common7/IDE/CommonExtensions/Microsoft/CMake/CMake/bin/cmake.exe" -DCMAKE_BUILD_TYPE:STRING=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE --no-warn-unused-cli -SD:/Dev/OtherGit/opencv -Bd:/Dev/OtherGit/opencv/build -G Ninja

[cmake] Not searching for unused variables given on the command line.

[cmake] -- Detected processor: AMD64

[cmake] -- libjpeg-turbo: VERSION = 3.0.3, BUILD = opencv-4.10.0-dev-libjpeg-turbo-debug

[cmake] -- SIMD extensions disabled: could not find NASM compiler.  Performance will suffer.

[cmake] -- Could NOT find OpenJPEG (minimal suitable version: 2.0, recommended version >= 2.3.1). OpenJPEG will be built from sources

[cmake] -- OpenJPEG: VERSION = 2.5.0, BUILD = opencv-4.10.0-dev-openjp2-2.5.0-debug

[cmake] -- OpenJPEG libraries will be built from sources: libopenjp2 (version "2.5.0")

[cmake] -- found Intel IPP (ICV version): 2021.12.0 [2021.12.0]

[cmake] -- at: D:/Dev/OtherGit/opencv/build/3rdparty/ippicv/ippicv_win/icv

[cmake] -- found Intel IPP Integration Wrappers sources: 2021.12.0

[cmake] -- at: D:/Dev/OtherGit/opencv/build/3rdparty/ippicv/ippicv_win/iw

[cmake] -- Could not find OpenBLAS include. Turning OpenBLAS_FOUND off

[cmake] -- Could not find OpenBLAS lib. Turning OpenBLAS_FOUND off

[cmake] -- Could NOT find BLAS (missing: BLAS_LIBRARIES)

[cmake] -- Could NOT find LAPACK (missing: LAPACK_LIBRARIES)

[cmake]     Reason given by package: LAPACK could not be found because dependency BLAS could not be found.

[cmake]

[cmake] -- VTK is not found. Please set -DVTK_DIR in CMake to VTK build directory, or to VTK install subdirectory with VTKConfig.cmake file

[cmake] -- Allocator metrics storage type: 'long long'

[cmake] -- Excluding from source files list: <BUILD>/modules/core/test/test_intrin256.lasx.cpp

[cmake] -- Excluding from source files list: modules/imgproc/src/imgwarp.lasx.cpp

[cmake] -- Excluding from source files list: modules/imgproc/src/resize.lasx.cpp

[cmake] -- Registering hook 'INIT_MODULE_SOURCES_opencv_dnn': D:/Dev/OtherGit/opencv/modules/dnn/cmake/hooks/INIT_MODULE_SOURCES_opencv_dnn.cmake

[cmake] -- opencv_dnn: filter out cuda4dnn source code

[cmake] -- Excluding from source files list: modules/dnn/src/layers/cpu_kernels/conv_winograd_f63.neon.cpp

[cmake] -- Excluding from source files list: <BUILD>/modules/dnn/layers/layers_common.rvv.cpp

[cmake] -- Excluding from source files list: <BUILD>/modules/dnn/layers/layers_common.lasx.cpp

[cmake] -- Excluding from source files list: <BUILD>/modules/dnn/int8layers/layers_common.rvv.cpp

[cmake] -- Excluding from source files list: <BUILD>/modules/dnn/int8layers/layers_common.lasx.cpp

[cmake] -- Excluding from source files list: <BUILD>/modules/dnn/layers/cpu_kernels/conv_block.neon.cpp

[cmake] -- Excluding from source files list: <BUILD>/modules/dnn/layers/cpu_kernels/conv_block.neon_fp16.cpp

[cmake] -- Excluding from source files list: <BUILD>/modules/dnn/layers/cpu_kernels/conv_depthwise.rvv.cpp

[cmake] -- Excluding from source files list: <BUILD>/modules/dnn/layers/cpu_kernels/conv_depthwise.lasx.cpp

[cmake] -- Excluding from source files list: <BUILD>/modules/dnn/layers/cpu_kernels/conv_winograd_f63.neon_fp16.cpp

[cmake] -- Excluding from source files list: <BUILD>/modules/dnn/layers/cpu_kernels/fast_gemm_kernels.neon.cpp

[cmake] -- Excluding from source files list: <BUILD>/modules/dnn/layers/cpu_kernels/fast_gemm_kernels.lasx.cpp

[cmake] -- imgcodecs: OpenEXR codec is disabled in runtime. Details: https://github.com/opencv/opencv/issues/21326

[cmake] -- highgui: using builtin backend: WIN32UI

[cmake] -- Use autogenerated whitelist D:/Dev/OtherGit/opencv/build/modules/js_bindings_generator/whitelist.json

[cmake] -- Found 'misc' Python modules from D:/Dev/OtherGit/opencv/modules/python/package/extra_modules

[cmake] -- Found 'mat_wrapper;utils' Python modules from D:/Dev/OtherGit/opencv/modules/core/misc/python/package

[cmake] -- Found 'gapi' Python modules from D:/Dev/OtherGit/opencv/modules/gapi/misc/python/package

[cmake] --

[cmake] -- General configuration for OpenCV 4.10.0-dev =====================================

[cmake] --   Version control:               4.10.0-317-g0f234209da

[cmake] --

[cmake] --   Platform:

[cmake] --     Timestamp:                   2024-10-11T07:56:33Z

[cmake] --     Host:                        Windows 10.0.19045 AMD64

[cmake] --     CMake:                       3.26.4-msvc4

[cmake] --     CMake generator:             Ninja

[cmake] --     CMake build tool:            D:/Program Files/ninja/ninja.exe

[cmake] --     MSVC:                        1937

[cmake] --     Configuration:               Debug

[cmake] --     Algorithm Hint:              ALGO_HINT_ACCURATE

[cmake] --

[cmake] --   CPU/HW features:

[cmake] --     Baseline:                    SSE SSE2 SSE3

[cmake] --       requested:                 SSE3

[cmake] --     Dispatched code generation:  SSE4_1 SSE4_2 AVX FP16 AVX2 AVX512_SKX

[cmake] --       SSE4_1 (18 files):         + SSSE3 SSE4_1

[cmake] --       SSE4_2 (2 files):          + SSSE3 SSE4_1 POPCNT SSE4_2

[cmake] --       AVX (9 files):             + SSSE3 SSE4_1 POPCNT SSE4_2 AVX

[cmake] --       FP16 (1 files):            + SSSE3 SSE4_1 POPCNT SSE4_2 AVX FP16

[cmake] --       AVX2 (38 files):           + SSSE3 SSE4_1 POPCNT SSE4_2 AVX FP16 AVX2 FMA3

[cmake] --       AVX512_SKX (8 files):      + SSSE3 SSE4_1 POPCNT SSE4_2 AVX FP16 AVX2 FMA3 AVX_512F AVX512_COMMON AVX512_SKX

[cmake] --

[cmake] --   C/C++:

[cmake] --     Built as dynamic libs?:      YES

[cmake] --     C++ standard:                11

[cmake] --     C++ Compiler:                D:/Program Files/Microsoft Visual Studio/2022/Professional/VC/Tools/MSVC/14.37.32822/bin/Hostx64/x64/cl.exe  (ver 19.37.32822.0)

[cmake] --     C++ flags (Release):         /DWIN32 /D_WINDOWS /W4 /GR  /D _CRT_SECURE_NO_DEPRECATE /D _CRT_NONSTDC_NO_DEPRECATE /D _SCL_SECURE_NO_WARNINGS /Gy /bigobj /Oi  /fp:precise /FS    /EHa /wd4127 /wd4251 /wd4324 /wd4275 /wd4512 /wd4589 /wd4819  /O2 /Ob2 /DNDEBUG

[cmake] --     C++ flags (Debug):           /DWIN32 /D_WINDOWS /W4 /GR  /D _CRT_SECURE_NO_DEPRECATE /D _CRT_NONSTDC_NO_DEPRECATE /D _SCL_SECURE_NO_WARNINGS /Gy /bigobj /Oi  /fp:precise /FS    /EHa /wd4127 /wd4251 /wd4324 /wd4275 /wd4512 /wd4589 /wd4819  /Zi /Ob0 /Od /RTC1

[cmake] --     C Compiler:                  D:/Program Files/Microsoft Visual Studio/2022/Professional/VC/Tools/MSVC/14.37.32822/bin/Hostx64/x64/cl.exe

[cmake] --     C flags (Release):           /DWIN32 /D_WINDOWS /W3  /D _CRT_SECURE_NO_DEPRECATE /D _CRT_NONSTDC_NO_DEPRECATE /D _SCL_SECURE_NO_WARNINGS /Gy /bigobj /Oi  /fp:precise /FS      /O2 /Ob2 /DNDEBUG

[cmake] --     C flags (Debug):             /DWIN32 /D_WINDOWS /W3  /D _CRT_SECURE_NO_DEPRECATE /D _CRT_NONSTDC_NO_DEPRECATE /D _SCL_SECURE_NO_WARNINGS /Gy /bigobj /Oi  /fp:precise /FS    /Zi /Ob0 /Od /RTC1

[cmake] --     Linker flags (Release):      /machine:x64  /INCREMENTAL:NO

[cmake] --     Linker flags (Debug):        /machine:x64  /debug /INCREMENTAL

[cmake] --     ccache:                      NO

[cmake] --     Precompiled headers:         NO

[cmake] --     Extra dependencies:

[cmake] --     3rdparty dependencies:

[cmake] --

[cmake] --   OpenCV modules:

[cmake] --     To be built:                 calib3d core dnn features2d flann gapi highgui imgcodecs imgproc java ml objdetect photo stitching ts video videoio

[cmake] --     Disabled:                    world

[cmake] --     Disabled by dependency:      -

[cmake] --     Unavailable:                 python2 python3

[cmake] --     Applications:                tests perf_tests apps

[cmake] --     Documentation:               NO

[cmake] --     Non-free algorithms:         NO

[cmake] --

[cmake] --   Windows RT support:            NO

[cmake] --

[cmake] --   GUI:                           WIN32UI

[cmake] --     Win32 UI:                    YES

[cmake] --     VTK support:                 NO

[cmake] --

[cmake] --   Media I/O:

[cmake] --     ZLib:                        build (ver 1.3.1)

[cmake] --     JPEG:                        build-libjpeg-turbo (ver 3.0.3-70)

[cmake] --       SIMD Support Request:      YES

[cmake] --       SIMD Support:              NO

[cmake] --     WEBP:                        build (ver encoder: 0x020f)

[cmake] --     PNG:                         build (ver 1.6.43)

[cmake] --       SIMD Support Request:      YES

[cmake] --       SIMD Support:              YES (Intel SSE)

[cmake] --     TIFF:                        build (ver 42 - 4.6.0)

[cmake] --     JPEG 2000:                   build (ver 2.5.0)

[cmake] --     OpenEXR:                     build (ver 2.3.0)

[cmake] --     HDR:                         YES

[cmake] --     SUNRASTER:                   YES

[cmake] --     PXM:                         YES

[cmake] --     PFM:                         YES

[cmake] --

[cmake] --   Video I/O:

[cmake] --     FFMPEG:                      YES (prebuilt binaries)

[cmake] --       avcodec:                   YES (58.134.100)

[cmake] --       avformat:                  YES (58.76.100)

[cmake] --       avutil:                    YES (56.70.100)

[cmake] --       swscale:                   YES (5.9.100)

[cmake] --       avresample:                YES (4.0.0)

[cmake] --     GStreamer:                   NO

[cmake] --     DirectShow:                  YES

[cmake] --     Media Foundation:            YES

[cmake] --       DXVA:                      YES

[cmake] --

[cmake] --   Parallel framework:            Concurrency

[cmake] --

[cmake] --   Trace:                         YES (with Intel ITT)

[cmake] --

[cmake] --   Other third-party libraries:

[cmake] --     Intel IPP:                   2021.12.0 [2021.12.0]

[cmake] --            at:                   D:/Dev/OtherGit/opencv/build/3rdparty/ippicv/ippicv_win/icv

[cmake] --     Intel IPP IW:                sources (2021.12.0)

[cmake] --               at:                D:/Dev/OtherGit/opencv/build/3rdparty/ippicv/ippicv_win/iw

[cmake] --     Lapack:                      NO

[cmake] --     Eigen:                       NO

[cmake] --     Custom HAL:                  NO

[cmake] --     Protobuf:                    build (3.19.1)

[cmake] --     Flatbuffers:                 builtin/3rdparty (23.5.9)

[cmake] --

[cmake] --   OpenCL:                        YES (NVD3D11)

[cmake] --     Include path:                D:/Dev/OtherGit/opencv/3rdparty/include/opencl/1.2

[cmake] --     Link libraries:              Dynamic load

[cmake] --

[cmake] --   Python (for build):            D:/Program Files/Python312/python.exe

[cmake] --

[cmake] --   Java:                          

[cmake] --     ant:                         NO

[cmake] --     Java:                        YES (ver 1.8.0.181)

[cmake] --     JNI:                         D:/Program Files/Java/jdk1.8.0_181/include D:/Program Files/Java/jdk1.8.0_181/include/win32 D:/Program Files/Java/jdk1.8.0_181/include

[cmake] --     Java wrappers:               YES (JAVA)

[cmake] --     Java tests:                  NO

[cmake] --

[cmake] --   Install to:                    D:/Dev/OtherGit/opencv/build/install

[cmake] -- -----------------------------------------------------------------

[cmake] --

[cmake] -- Configuring done (5.7s)

[cmake] -- Generating done (0.5s)

[cmake] -- Build files have been written to: D:/Dev/OtherGit/opencv/build
```

可以看到，配置过程中，直接下载了`ffmpeg`的动态库包，只不过未开启交叉编译linux版本的话，下载的动态库仅有dll。且Video I/O模块中的FFMPEG已经是YES状态了

随后我做了如下改动，将编译类型从`Debug`改为了`Release`，将opencv源码从`4.x`分支切换到了tag`4.10.0`上

现在将进行cmake编译选项配置，将opencv库编译成world版本（即集大成的动态库文件），这样方便集成到其他平台

找到`CMakeCache.txt`文件，查看其中的配置项

```txt
//Build shared libraries (.dll/.so) instead of static ones (.lib/.a)
BUILD_SHARED_LIBS:BOOL=ON
```

可以看到，默认就是编译成动态库的，这里不用修改

```txt
//Include opencv_world module into the OpenCV build
BUILD_opencv_world:BOOL=OFF
```

可以看到，默认不是编译成world，这里改为ON

```txt
//Include FFMPEG/libavdevice library support.
OPENCV_FFMPEG_ENABLE_LIBAVDEVICE:BOOL=OFF
```

可以看到，默认未开启ffmpeg的音频支持，这里改为ON

不修改`CMakeCache.txt`中的值，因为每次配置都会覆盖其中的选项，通过vscode的`code-workspace`工作区文件，在其中设置`setting`，来控制开关，代码如下：
```json
{
    "folders": [
        {
            "path": "."
        }
    ],
    "settings": {
        "cmake.configureArgs": [
            "-DBUILD_opencv_world=ON",
            "-DOPENCV_FFMPEG_ENABLE_LIBAVDEVICE=ON"
        ]
    }
}

```

重新配置cmake工程，发现Cache中的开关已经被修改
注意，因为我这里使用的vscode早期已经对cmake工程的默认安装目录进行了设置，设置在了每一个cmake工程的`build/install`相对路径下。如有需要请自行修改此配置`CMAKE_INSTALL_PREFIX`

接下来开始编译，我这里选择的是构建`opencv_world`，其会输出一个`opencv_world4100.dll`在我的`build/bin`目录下。

编译正常通过，没有报错。我又选择了构建`install`，将库所需头文件和其他依赖安装到`build/install`文件夹中。

安装完成，我的目录结构大致如下：

```txt
-etc
-include
 -opencv2
-x64
 -vc17
  -bin
   -opencv_videoio_ffmpeg4100_64.dll
   -opencv_world4100.dll
  -lib
```

其中我最需要的就是world.dll和ffmpeg.dll这两个库，以及include中的opencv2头文件

接下来尝试集成到ue，看看是否接口有变动以及打包是否能成功

已测试使用到的接口没有变动

接下来就是使用opencv库中自带集成的ffmpeg进行视频保存，查阅代码发现：

```c++
// cap_ffmpeg_legacy_api.hpp
OPENCV_FFMPEG_API struct CvVideoWriter_FFMPEG* cvCreateVideoWriter_FFMPEG(const char* filename,
            int fourcc, double fps, int width, int height, int isColor );
OPENCV_FFMPEG_API int cvWriteFrame_FFMPEG(struct CvVideoWriter_FFMPEG* writer, const unsigned char* data,
                                          int step, int width, int height, int cn, int origin);
OPENCV_FFMPEG_API void cvReleaseVideoWriter_FFMPEG(struct CvVideoWriter_FFMPEG** writer);
```



[OPenCV高级编程——OpenCV视频读写及录制技术详解](https://blog.csdn.net/weixin_62621696/article/details/140828188)

思路：既然播放视频是将视频帧的cv::Mat转成了ue的Texture2D。那同理可以在程序运行时，将ue的Texture2D转成cv::Mat，然后再保存为视频文件。现在差了一个技术点，就是如何利用opencv库中集成的ffmpeg进行推流，考察是否可行