cmake_dependent_option可用于option依赖设置

### 打印编译器信息
```cmake
message(STATUS "Is the C++ compiler loaded? ${CMAKE_CXX_COMPILER_LOADED}")
if(CMAKE_CXX_COMPILER_LOADED)
	message(STATUS "The C++ compiler ID is: ${CMAKE_CXX_COMPILER_ID}")
	message(STATUS "Is the C++ from GNU? ${CMAKE_COMPILER_IS_GNUCXX}")
	message(STATUS "The C++ compiler version is: ${CMAKE_CXX_COMPILER_VERSION}")
endif()

message(STATUS "Is the C compiler loaded? ${CMAKE_C_COMPILER_LOADED}")
if(CMAKE_C_COMPILER_LOADED)
	message(STATUS "The C compiler ID is: ${CMAKE_C_COMPILER_ID}")
	message(STATUS "Is the C from GNU? ${CMAKE_COMPILER_IS_GNUCC}")
	message(STATUS "The C compiler version is: ${CMAKE_C_COMPILER_VERSION}")
endif()
```

### 可见性说明
可见性的含义如下:

- **PRIVATE**，编译选项会应用于给定的目标，不会传递给与目标相关的目标。我们的示例中， 即使`compute-areas`将链接到`geometry`库，`compute-areas`也不会继承`geometry`目标上设置的编译器选项。
- **INTERFACE**，给定的编译选项将只应用于指定目标，并传递给与目标相关的目标。
- **PUBLIC**，编译选项将应用于指定目标和使用它的目标。

### 动态库

设置导出所有符号： set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)  
Windows平台下生成dll时，设置这个参数， 则动态库中，将导出所有的函数符号；否则，就只有在接口中声明了  __declspec(dllexport)  的接口函数，才会被导出符号；

为目标设置了`CXX_STANDARD`、`CXX_EXTENSIONS`和`CXX_STANDARD_REQUIRED`属性。还设置了`position_independent ent_code`属性，以避免在使用一些编译器构建DSO时出现问题:


    ```cmake
    set_target_properties(animals
      PROPERTIES
        CXX_STANDARD 14
        CXX_EXTENSIONS OFF
        CXX_STANDARD_REQUIRED ON
        POSITION_INDEPENDENT_CODE 1
    )
    ```


### 源文件编译属性

CMake代码片段中引入了另外两个新命令:

- `set_source_files_properties(file PROPERTIES property value)` ，它将属性设置为给定文件的传递值。与目标非常相似，文件在CMake中也有属性，允许对构建系统进行非常细粒度的控制。源文件的可用属性列表可以在这里找到: [https://cmake.org/cmake/help/v3.5/manual/cmake-properties.7.html#source-file-properties](https://cmake.org/cmake/help/v3.5/manual/cmake-properties.7.html#source-file-properties) 。
- `get_source_file_property(VAR file property)`，检索给定文件所需属性的值，并将其存储在CMake`VAR`变量中。

可以通过
set_source_files_properties(${_source} PROPERTIES COMPILE_FLAGS -O2)
动态调整源文件优化级别

### list和set

_CMake中，列表是用分号分隔的字符串组。列表可以由`list`或`set`命令创建。例如，`set(var a b c d e)`和`list(APPEND a b c d e)`都创建了列表`a;b;c;d;e`。_


可以使用`cmake --help-module-list`获得现有模块的列表。但是，不是所有的库和程序都包含在其中，有时必须自己编写检测脚本。本章将讨论相应的工具，了解CMake的`find`族命令:

- **find_file**：在相应路径下查找命名文件
- **find_library**：查找一个库文件
- **find_package**：从外部项目查找和加载设置
- **find_path**：查找包含指定文件的目录
- **find_program**：找到一个可执行程序

### target_sources用法
https://blog.csdn.net/guaaaaaaa/article/details/125601766


### dll宏
如果你在另一个CMake项目中使用了这个库，而且没有包含这个库的源代码，只是链接了库文件和包含了头文件，那么`CORE_API`的宏定义仍然存在，但其值取决于库本身的设置和当前项目的配置。

1. 如果库在构建时是用`__declspec(dllexport)`定义的，而你的项目是在Windows上，那么`CORE_API`的值将是`__declspec(dllimport)`，因为Windows下链接动态库时，通常会使用`__declspec(dllimport)`来指示链接器从DLL中导入符号。

2. 如果库在构建时是用`__attribute__((visibility("default")))`定义的，或者你的项目是在非Windows平台上，那么`CORE_API`的值将保持为`__attribute__((visibility("default")))`，因为在这些情况下，通常不需要`__declspec(dllimport)`。

这种自动适应不同平台的宏定义是通过CMake在库的构建过程中设置的，并且会在链接到该库的项目中继续生效，确保链接到库的项目在不同平台上都能正确使用。但请注意，这只有在库的构建配置正确的情况下才有效，库的作者应该确保在构建库时设置了正确的导出宏。

是的，通常情况下，如果你正在开发一个DLL库，并且想让其他项目能够正确导入它，你只需要在你的库中将需要导出的函数或符号声明为`__declspec(dllexport)`（在Windows上）或者使用合适的导出属性（在其他平台上）即可。

其他项目在链接到你的库并调用其中的函数时，默认情况下会自动使用适当的导入宏，不需要在每个使用你的库的项目中手动定义导入宏。这是因为链接器会根据库中的导出声明自动设置导入宏。

例如，在Windows上，如果你的库中有以下导出声明：

```cpp
__declspec(dllexport) void MyExportedFunction();
```

其他项目在链接你的库并调用`MyExportedFunction`时，无需手动定义导入宏，链接器会自动将它标记为`__declspec(dllimport)`。

总之，只需在库中进行适当的导出声明，然后其他项目将能够正确导入你的库的函数和符号。在CMake中，你可以按照前面提到的方式来设置这些导出声明，以确保库在不同平台上都能正常工作。


### C++中定义导出宏

```cpp
/*
 *  Copyright (c) 2018 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#ifndef RTC_BASE_SYSTEM_RTC_EXPORT_H_
#define RTC_BASE_SYSTEM_RTC_EXPORT_H_

// RTC_EXPORT is used to mark symbols as exported or imported when WebRTC is
// built or used as a shared library.
// When WebRTC is built as a static library the RTC_EXPORT macro expands to
// nothing.

#ifdef WEBRTC_ENABLE_SYMBOL_EXPORT

#ifdef WEBRTC_WIN

#ifdef WEBRTC_LIBRARY_IMPL
#define RTC_EXPORT __declspec(dllexport)
#else
#define RTC_EXPORT __declspec(dllimport)
#endif

#else  // WEBRTC_WIN

#if __has_attribute(visibility) && defined(WEBRTC_LIBRARY_IMPL)
#define RTC_EXPORT __attribute__((visibility("default")))
#endif

#endif  // WEBRTC_WIN

#endif  // WEBRTC_ENABLE_SYMBOL_EXPORT

#ifndef RTC_EXPORT
#define RTC_EXPORT
#endif

#endif  // RTC_BASE_SYSTEM_RTC_EXPORT_H_

```

### 字符串转大写

在CMake中，你可以使用`string(TOUPPER)`命令将一个字符串的值转换为大写，并将结果存储在另一个变量中。以下是使用这个命令的示例：

```cmake
# 定义一个字符串变量
set(original_string "Hello, World!")

# 使用string(TOUPPER)将原始字符串变为大写并存储在另一个变量中
string(TOUPPER "${original_string}" uppercase_string)

# 打印结果
message("Original String: ${original_string}")
message("Uppercase String: ${uppercase_string}")
```

在这个示例中，`original_string`包含"Hello, World!"，然后使用`string(TOUPPER)`将其转换为大写并存储在`uppercase_string`变量中。最后，通过`message`命令打印原始字符串和大写字符串的值。

运行上述CMake脚本，你将看到以下输出：

```
Original String: Hello, World!
Uppercase String: HELLO, WORLD!
```

这样，你可以使用`string(TOUPPER)`命令将字符串变量的值转换为大写，并将其用于需要大写字符串的地方。

### CMake中查看一个target的宏定义

要获取一个CMake目标（例如一个库或可执行文件）中包含的宏定义，你可以使用`target_compile_definitions`命令获取目标的编译定义。这将返回与目标关联的宏定义列表。你可以将这些宏定义保存到一个变量中，然后在后续的CMake代码中使用。

以下是一个示例：

```cmake
# 获取目标的编译定义
get_target_property(target_definitions YourTargetName COMPILE_DEFINITIONS)

# 将编译定义保存到一个变量中
set(target_definitions_list ${target_definitions})

# 打印编译定义
message("Target Definitions: ${target_definitions_list}")
```

在这个示例中，将`YourTargetName`替换为你的目标的名称。`get_target_property`用于获取目标的编译定义，然后将其保存到一个变量中。最后，使用`message`命令打印出这些编译定义。

这样，你就可以获取目标中包含的宏定义并在CMake中使用它们。
