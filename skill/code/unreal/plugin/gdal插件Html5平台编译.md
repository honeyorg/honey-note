#ue #build #html5 #plugins #gdal

先编译Editor Win64 Development版本的，编过之后启动编辑器

[UE4.27 源码版 可打包HTML5版本 （Windows）](https://www.jindouyun.cn/document/industry/details/182146)

记录一次报错

```log
UATHelper: 打包 (HTML5):     [660/661] HtmlPro.js
UATHelper: 打包 (HTML5):     emcc: warning: DEMANGLE_SUPPORT is deprecated (mangled names no longer appear in stack traces). Please open a bug if you have a continuing need for this setting [-Wdeprecated]
UATHelper: 打包 (HTML5):     wasm-ld: warning: function signature mismatch: gdal_crc32_combine
UATHelper: 打包 (HTML5):     >>> defined as (i32, i32, i64) -> i32 in D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPIGDAL\\Source\\OpenZIAPIGDAL\\ThirdParty\\GDAL\\html5\\lib\\libgdal.a(cpl_vsil_gzip.cpp.o)
UATHelper: 打包 (HTML5):     >>> defined as (i32, i32, i32) -> i32 in D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPIGDAL\\Source\\OpenZIAPIGDAL\\ThirdParty\\GDAL\\html5\\lib\\libgdal.a(crc32.c.o)
UATHelper: 打包 (HTML5):   
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.1_of_14.cpp.o: undefined symbol: icu_64::Locale::getDefault()
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.1_of_14.cpp.o: undefined symbol: icu_64::Locale::Locale(icu_64::Locale const&)
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.1_of_14.cpp.o: undefined symbol: icu_64::Locale::~Locale()
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: u_setMemoryFunctions_64
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: u_setDataDirectory_64
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: udata_setFileAccess_64
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: u_setDataFileFunctions_64
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: u_init_64
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: icu_64::UMemory::operator new(unsigned long)
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: icu_64::GregorianCalendar::GregorianCalendar(UErrorCode&)
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: icu_64::TimeZone::getUnknown()
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: icu_64::Calendar::setTimeZone(icu_64::TimeZone const&)
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: icu_64::BreakIterator::createCharacterInstance(icu_64::Locale const&, UErrorCode&)
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: icu_64::BreakIterator::createWordInstance(icu_64::Locale const&, UErrorCode&)
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: icu_64::BreakIterator::createLineInstance(icu_64::Locale const&, UErrorCode&)
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: icu_64::BreakIterator::createSentenceInstance(icu_64::Locale const&, UErrorCode&)
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: icu_64::BreakIterator::createTitleInstance(icu_64::Locale const&, UErrorCode&)
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: icu_64::UMemory::operator new(unsigned long)
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: icu_64::UMemory::operator new(unsigned long)
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: icu_64::UnicodeString::countChar32(int, int) const
UATHelper: 打包 (HTML5):     wasm-ld: error: too many errors emitted, stopping now (use -error-limit=0 to see all errors)
UATHelper: 打包 (HTML5):     emcc: error: 'D:/Dev/UE-HTML5-4.27/Engine/Platforms/HTML5/Build/emsdk/emsdk-3.1.56/upstream/bin\wasm-ld.exe @D:\Dev\UE-HTML5-4.27\Engine\Platforms\HTML5\Build\emsdk\emsdk-3.1.56\tmp\emscripten_lno759o7.rsp.utf-8' failed (returned 1)
PackagingResults: Warning: DEMANGLE_SUPPORT is deprecated (mangled names no longer appear in stack traces). Please open a bug if you have a continuing need for this setting [-Wdeprecated]
PackagingResults: Warning: function signature mismatch: gdal_crc32_combine
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.1_of_14.cpp.o: undefined symbol: icu_64::Locale::getDefault()
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.1_of_14.cpp.o: undefined symbol: icu_64::Locale::Locale(icu_64::Locale const&)
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.1_of_14.cpp.o: undefined symbol: icu_64::Locale::~Locale()
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: u_setMemoryFunctions_64
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: u_setDataDirectory_64
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: udata_setFileAccess_64
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: u_setDataFileFunctions_64
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: u_init_64
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: icu_64::UMemory::operator new(unsigned long)
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: icu_64::GregorianCalendar::GregorianCalendar(UErrorCode&)
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: icu_64::TimeZone::getUnknown()
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: icu_64::Calendar::setTimeZone(icu_64::TimeZone const&)
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: icu_64::BreakIterator::createCharacterInstance(icu_64::Locale const&, UErrorCode&)
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: icu_64::BreakIterator::createWordInstance(icu_64::Locale const&, UErrorCode&)
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: icu_64::BreakIterator::createLineInstance(icu_64::Locale const&, UErrorCode&)
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: icu_64::BreakIterator::createSentenceInstance(icu_64::Locale const&, UErrorCode&)
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: icu_64::BreakIterator::createTitleInstance(icu_64::Locale const&, UErrorCode&)
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: icu_64::UMemory::operator new(unsigned long)
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: icu_64::UMemory::operator new(unsigned long)
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\Core\\Module.Core.5_of_14.cpp.o: undefined symbol: icu_64::UnicodeString::countChar32(int, int) const
PackagingResults: Error: too many errors emitted, stopping now (use -error-limit=0 to see all errors)
PackagingResults: Error: 'D:/Dev/UE-HTML5-4.27/Engine/Platforms/HTML5/Build/emsdk/emsdk-3.1.56/upstream/bin\wasm-ld.exe @D:\Dev\UE-HTML5-4.27\Engine\Platforms\HTML5\Build\emsdk\emsdk-3.1.56\tmp\emscripten_lno759o7.rsp.utf-8' failed (returned 1)
UATHelper: 打包 (HTML5): Took 435.0742686s to run UnrealBuildTool.exe, ExitCode=6
UATHelper: 打包 (HTML5): UnrealBuildTool failed. See log for more details. (D:\Dev\UE-HTML5-4.27\Engine\Programs\AutomationTool\Saved\Logs\UBT-HtmlPro-HTML5-Development.txt)
UATHelper: 打包 (HTML5): AutomationTool exiting with ExitCode=6 (6)
UATHelper: 打包 (HTML5): BUILD FAILED
PackagingResults: Error: Unknown Error
```

在`Engine/Platforms/HTML5/Source/ThirdParty/`下添加一些64位库应该就可以了

新的报错：
```log
UATHelper: 打包 (HTML5):     [1/2] HtmlPro.js
UATHelper: 打包 (HTML5):     emcc: warning: DEMANGLE_SUPPORT is deprecated (mangled names no longer appear in stack traces). Please open a bug if you have a continuing need for this setting [-Wdeprecated]
UATHelper: 打包 (HTML5):     wasm-ld: warning: function signature mismatch: gdal_crc32_combine
UATHelper: 打包 (HTML5):     >>> defined as (i32, i32, i64) -> i32 in D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPIGDAL\\Source\\OpenZIAPIGDAL\\ThirdParty\\GDAL\\html5\\lib\\libgdal.a(cpl_vsil_gzip.cpp.o)
UATHelper: 打包 (HTML5):     >>> defined as (i32, i32, i32) -> i32 in D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPIGDAL\\Source\\OpenZIAPIGDAL\\ThirdParty\\GDAL\\html5\\lib\\libgdal.a(crc32.c.o)
UATHelper: 打包 (HTML5):   
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::Isolate::Enter()
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::FunctionTemplate::New(v8::Isolate*, void (*)(v8::FunctionCallbackInfo<v8::Value> const&), v8::Local<v8::Value>, v8::Local<v8::Signature>, int, v8::ConstructorBehavior, v8::SideEf
fectType, v8::CFunction const*)
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::FunctionTemplate::InstanceTemplate()
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::ObjectTemplate::SetInternalFieldCount(int)
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::FunctionTemplate::PrototypeTemplate()
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::String::NewFromUtf8(v8::Isolate*, char const*, v8::NewStringType, int)
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::V8::ToLocalEmpty()
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::FunctionTemplate::New(v8::Isolate*, void (*)(v8::FunctionCallbackInfo<v8::Value> const&), v8::Local<v8::Value>, v8::Local<v8::Signature>, int, v8::ConstructorBehavior, v8::SideEf
fectType, v8::CFunction const*)
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::Template::Set(v8::Local<v8::Name>, v8::Local<v8::Data>, v8::PropertyAttribute)
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::FunctionTemplate::PrototypeTemplate()
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::String::NewFromUtf8(v8::Isolate*, char const*, v8::NewStringType, int)
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::V8::ToLocalEmpty()
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::FunctionTemplate::New(v8::Isolate*, void (*)(v8::FunctionCallbackInfo<v8::Value> const&), v8::Local<v8::Value>, v8::Local<v8::Signature>, int, v8::ConstructorBehavior, v8::SideEf
fectType, v8::CFunction const*)
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::Template::Set(v8::Local<v8::Name>, v8::Local<v8::Data>, v8::PropertyAttribute)
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::FunctionTemplate::PrototypeTemplate()
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::String::NewFromUtf8(v8::Isolate*, char const*, v8::NewStringType, int)
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::V8::ToLocalEmpty()
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::FunctionTemplate::New(v8::Isolate*, void (*)(v8::FunctionCallbackInfo<v8::Value> const&), v8::Local<v8::Value>, v8::Local<v8::Signature>, int, v8::ConstructorBehavior, v8::SideEf
fectType, v8::CFunction const*)
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::Template::Set(v8::Local<v8::Name>, v8::Local<v8::Data>, v8::PropertyAttribute)
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::FunctionTemplate::PrototypeTemplate()
UATHelper: 打包 (HTML5):     wasm-ld: error: too many errors emitted, stopping now (use -error-limit=0 to see all errors)
UATHelper: 打包 (HTML5):     emcc: error: 'D:/Dev/UE-HTML5-4.27/Engine/Platforms/HTML5/Build/emsdk/emsdk-3.1.56/upstream/bin\wasm-ld.exe @D:\Dev\UE-HTML5-4.27\Engine\Platforms\HTML5\Build\emsdk\emsdk-3.1.56\tmp\emscripten_o2jhji64.rsp.utf-8' failed (returned 1)
PackagingResults: Warning: DEMANGLE_SUPPORT is deprecated (mangled names no longer appear in stack traces). Please open a bug if you have a continuing need for this setting [-Wdeprecated]
PackagingResults: Warning: function signature mismatch: gdal_crc32_combine
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::Isolate::Enter()
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::FunctionTemplate::New(v8::Isolate*, void (*)(v8::FunctionCallbackInfo<v8::Value> const&), v8::Local<v8::Value>, v8::Local<v8::Signature>, int, v8::ConstructorBehavior, v8::SideEffectType, v8::CFun
ction const*)
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::FunctionTemplate::InstanceTemplate()
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::ObjectTemplate::SetInternalFieldCount(int)
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::FunctionTemplate::PrototypeTemplate()
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::String::NewFromUtf8(v8::Isolate*, char const*, v8::NewStringType, int)
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::V8::ToLocalEmpty()
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::FunctionTemplate::New(v8::Isolate*, void (*)(v8::FunctionCallbackInfo<v8::Value> const&), v8::Local<v8::Value>, v8::Local<v8::Signature>, int, v8::ConstructorBehavior, v8::SideEffectType, v8::CFun
ction const*)
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::Template::Set(v8::Local<v8::Name>, v8::Local<v8::Data>, v8::PropertyAttribute)
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::FunctionTemplate::PrototypeTemplate()
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::String::NewFromUtf8(v8::Isolate*, char const*, v8::NewStringType, int)
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::V8::ToLocalEmpty()
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::FunctionTemplate::New(v8::Isolate*, void (*)(v8::FunctionCallbackInfo<v8::Value> const&), v8::Local<v8::Value>, v8::Local<v8::Signature>, int, v8::ConstructorBehavior, v8::SideEffectType, v8::CFun
ction const*)
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::Template::Set(v8::Local<v8::Name>, v8::Local<v8::Data>, v8::PropertyAttribute)
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::FunctionTemplate::PrototypeTemplate()
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::String::NewFromUtf8(v8::Isolate*, char const*, v8::NewStringType, int)
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::V8::ToLocalEmpty()
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::FunctionTemplate::New(v8::Isolate*, void (*)(v8::FunctionCallbackInfo<v8::Value> const&), v8::Local<v8::Value>, v8::Local<v8::Signature>, int, v8::ConstructorBehavior, v8::SideEffectType, v8::CFun
ction const*)
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::Template::Set(v8::Local<v8::Name>, v8::Local<v8::Data>, v8::PropertyAttribute)
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Intermediate\\Build\\HTML5\\HtmlPro\\Development\\JsEnv\\Module.JsEnv.1_of_3.cpp.o: undefined symbol: v8::FunctionTemplate::PrototypeTemplate()
PackagingResults: Error: too many errors emitted, stopping now (use -error-limit=0 to see all errors)
PackagingResults: Error: 'D:/Dev/UE-HTML5-4.27/Engine/Platforms/HTML5/Build/emsdk/emsdk-3.1.56/upstream/bin\wasm-ld.exe @D:\Dev\UE-HTML5-4.27\Engine\Platforms\HTML5\Build\emsdk\emsdk-3.1.56\tmp\emscripten_o2jhji64.rsp.utf-8' failed (returned 1)
UATHelper: 打包 (HTML5): Took 7.3385764s to run UnrealBuildTool.exe, ExitCode=6
UATHelper: 打包 (HTML5): UnrealBuildTool failed. See log for more details. (D:\Dev\UE-HTML5-4.27\Engine\Programs\AutomationTool\Saved\Logs\UBT-HtmlPro-HTML5-Development.txt)
UATHelper: 打包 (HTML5): AutomationTool exiting with ExitCode=6 (6)
UATHelper: 打包 (HTML5): BUILD FAILED
PackagingResults: Error: Unknown Error
```

Puerts插件的问题，暂时移除Puerts插件依赖，反正不测试ts侧代码。继续打包，得到新的报错：
```log
UATHelper: 打包 (HTML5):     [1/2] HtmlPro.js
UATHelper: 打包 (HTML5):     emcc: warning: DEMANGLE_SUPPORT is deprecated (mangled names no longer appear in stack traces). Please open a bug if you have a continuing need for this setting [-Wdeprecated]
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFCurrentDirOffset
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFIsTiled
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFGetField
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFGetField
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFGetField
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFGetField
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFGetField
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFGetField
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFCurrentDirOffset
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFSetSubDirectory
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFTileSize64
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFStripSize64
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFReadEncodedTile
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFReadEncodedStrip
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFCurrentDirOffset
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFSetSubDirectory
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFTileSize64
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFStripSize64
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFReadEncodedTile
UATHelper: 打包 (HTML5):     wasm-ld: error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFReadEncodedStrip
UATHelper: 打包 (HTML5):     wasm-ld: error: too many errors emitted, stopping now (use -error-limit=0 to see all errors)
UATHelper: 打包 (HTML5):     emcc: error: 'D:/Dev/UE-HTML5-4.27/Engine/Platforms/HTML5/Build/emsdk/emsdk-3.1.56/upstream/bin\wasm-ld.exe @D:\Dev\UE-HTML5-4.27\Engine\Platforms\HTML5\Build\emsdk\emsdk-3.1.56\tmp\emscripten_akbigd52.rsp.utf-8' failed (returned 1)
PackagingResults: Warning: DEMANGLE_SUPPORT is deprecated (mangled names no longer appear in stack traces). Please open a bug if you have a continuing need for this setting [-Wdeprecated]
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFCurrentDirOffset
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFIsTiled
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFGetField
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFGetField
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFGetField
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFGetField
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFGetField
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFGetField
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFCurrentDirOffset
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFSetSubDirectory
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFTileSize64
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFStripSize64
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFReadEncodedTile
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFReadEncodedStrip
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFCurrentDirOffset
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFSetSubDirectory
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFTileSize64
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFStripSize64
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFReadEncodedTile
PackagingResults: Error: D:\\Dev\\Html5\\unreal\\HtmlPro\\Plugins\\OpenZIAPI\\Source\\ThirdParty\\html5\\lib\\libproj.a(grids.cpp.o): undefined symbol: TIFFReadEncodedStrip
PackagingResults: Error: too many errors emitted, stopping now (use -error-limit=0 to see all errors)
PackagingResults: Error: 'D:/Dev/UE-HTML5-4.27/Engine/Platforms/HTML5/Build/emsdk/emsdk-3.1.56/upstream/bin\wasm-ld.exe @D:\Dev\UE-HTML5-4.27\Engine\Platforms\HTML5\Build\emsdk\emsdk-3.1.56\tmp\emscripten_akbigd52.rsp.utf-8' failed (returned 1)
UATHelper: 打包 (HTML5): Took 4.6982828s to run UnrealBuildTool.exe, ExitCode=6
UATHelper: 打包 (HTML5): UnrealBuildTool failed. See log for more details. (D:\Dev\UE-HTML5-4.27\Engine\Programs\AutomationTool\Saved\Logs\UBT-HtmlPro-HTML5-Development.txt)
UATHelper: 打包 (HTML5): AutomationTool exiting with ExitCode=6 (6)
UATHelper: 打包 (HTML5): BUILD FAILED
PackagingResults: Error: Unknown Error
```

和之前编译gdal库的时候遇到的报错一样[[UE4.27Html5编译]]，再次检查gdal源码，发现其逻辑是这样的：
默认开启了`GDAL_USE_TIFF_INTERNAL`，即默认使用源码内部的tiff源码来编译tiff库，所以之前即便关闭了RENAME的开关，仍然会导致一些问题，重新编译gdal源码，关闭`GDAL_USE_TIFF_INTERNAL`开关。尝试打包，还是不行


突然想起来，tiff是C库，proj是C++库。严重怀疑是包含tiff头文件出的问题，导致C++库编译时因为重载机制对接口符号命名添加了重载后缀！查看proj源码，搜索`#include "tiffio.h"`，发现正是`grids.cpp`中引用的，源码如下：
```cpp
#ifdef TIFF_ENABLED
#include "tiffio.h"
#endif
```

没有用`extern "C"`包裹，改为如下代码，重新编译proj库：
```cpp
#ifdef TIFF_ENABLED
extern "C" {
#include "tiffio.h"
}
#endif
```


cook失败了，日志如下：
```log
PackagingResults: Error: Errors compiling global shader FHairCardsDeformationCS  :
UATHelper: 打包 (HTML5):   LogWindows: Error: begin: stack for UAT
UATHelper: 打包 (HTML5):   LogWindows: Error: === Critical error: ===
UATHelper: 打包 (HTML5):   LogWindows: Error:
UATHelper: 打包 (HTML5):   LogWindows: Error: Fatal error: [File:D:/Dev/UE-HTML5-4.27/Engine/Source/Runtime/Engine/Private/ShaderCompiler/ShaderCompiler.cpp] [Line: 6109]
UATHelper: 打包 (HTML5):   LogWindows: Error: Failed to compile global shader FHairCardsDeformationCS  .  Enable 'r.ShaderDevelopmentMode' in ConsoleVariables.ini for retries.
UATHelper: 打包 (HTML5):   LogWindows: Error:
UATHelper: 打包 (HTML5):   LogWindows: Error:
UATHelper: 打包 (HTML5):   LogWindows: Error: [Callstack] 0x00007ff917b4b699 KERNELBASE.dll!UnknownFunction []
UATHelper: 打包 (HTML5):   LogWindows: Error: [Callstack] 0x00007ff858fd4aa6 UE4Editor-Core.dll!ReportAssert() [D:\Dev\UE-HTML5-4.27\Engine\Source\Runtime\Core\Private\Windows\WindowsPlatformCrashContext.cpp:1644]
UATHelper: 打包 (HTML5):   LogWindows: Error: [Callstack] 0x00007ff858fd8b68 UE4Editor-Core.dll!FWindowsErrorOutputDevice::Serialize() [D:\Dev\UE-HTML5-4.27\Engine\Source\Runtime\Core\Private\Windows\WindowsErrorOutputDevice.cpp:78]
UATHelper: 打包 (HTML5):   LogWindows: Error: [Callstack] 0x00007ff858ce88ed UE4Editor-Core.dll!FOutputDevice::LogfImpl() [D:\Dev\UE-HTML5-4.27\Engine\Source\Runtime\Core\Private\Misc\OutputDevice.cpp:61]
UATHelper: 打包 (HTML5):   LogWindows: Error: [Callstack] 0x00007ff856239286 UE4Editor-Engine.dll!ProcessCompiledGlobalShaders() [D:\Dev\UE-HTML5-4.27\Engine\Source\Runtime\Engine\Private\ShaderCompiler\ShaderCompiler.cpp:6129]
UATHelper: 打包 (HTML5):   LogWindows: Error: [Callstack] 0x00007ff85623aba3 UE4Editor-Engine.dll!FShaderCompilingManager::ProcessCompiledShaderMaps() [D:\Dev\UE-HTML5-4.27\Engine\Source\Runtime\Engine\Private\ShaderCompiler\ShaderCompiler.cpp:3498]
UATHelper: 打包 (HTML5):   LogWindows: Error: [Callstack] 0x00007ff856238417 UE4Editor-Engine.dll!FShaderCompilingManager::ProcessAsyncResults() [D:\Dev\UE-HTML5-4.27\Engine\Source\Runtime\Engine\Private\ShaderCompiler\ShaderCompiler.cpp:4047]
UATHelper: 打包 (HTML5):   LogWindows: Error: [Callstack] 0x00007ff856241543 UE4Editor-Engine.dll!RecompileShadersForRemote() [D:\Dev\UE-HTML5-4.27\Engine\Source\Runtime\Engine\Private\ShaderCompiler\ShaderCompiler.cpp:6012]
UATHelper: 打包 (HTML5):   LogWindows: Error: [Callstack] 0x00007ff85302704d UE4Editor-UnrealEd.dll!UCookOnTheFlyServer::SaveGlobalShaderMapFiles() [D:\Dev\UE-HTML5-4.27\Engine\Source\Editor\UnrealEd\Private\CookOnTheFlyServer.cpp:5577]
UATHelper: 打包 (HTML5):   LogWindows: Error: [Callstack] 0x00007ff85302c5fb UE4Editor-UnrealEd.dll!UCookOnTheFlyServer::StartCookByTheBook() [D:\Dev\UE-HTML5-4.27\Engine\Source\Editor\UnrealEd\Private\CookOnTheFlyServer.cpp:6942]
UATHelper: 打包 (HTML5):   LogWindows: Error: [Callstack] 0x00007ff852e3ecb9 UE4Editor-UnrealEd.dll!UCookCommandlet::CookByTheBook() [D:\Dev\UE-HTML5-4.27\Engine\Source\Editor\UnrealEd\Private\Commandlets\CookCommandlet.cpp:966]
UATHelper: 打包 (HTML5):   LogWindows: Error: [Callstack] 0x00007ff852e696d8 UE4Editor-UnrealEd.dll!UCookCommandlet::Main() [D:\Dev\UE-HTML5-4.27\Engine\Source\Editor\UnrealEd\Private\Commandlets\CookCommandlet.cpp:663]
UATHelper: 打包 (HTML5):   LogWindows: Error: [Callstack] 0x00007ff7f5169c8a UE4Editor-Cmd.exe!FEngineLoop::PreInitPostStartupScreen() [D:\Dev\UE-HTML5-4.27\Engine\Source\Runtime\Launch\Private\LaunchEngineLoop.cpp:3434]
UATHelper: 打包 (HTML5):   LogWindows: Error: [Callstack] 0x00007ff7f5160d6d UE4Editor-Cmd.exe!GuardedMain() [D:\Dev\UE-HTML5-4.27\Engine\Source\Runtime\Launch\Private\Launch.cpp:132]
UATHelper: 打包 (HTML5):   LogWindows: Error: [Callstack] 0x00007ff7f51610fa UE4Editor-Cmd.exe!GuardedMainWrapper() [D:\Dev\UE-HTML5-4.27\Engine\Source\Runtime\Launch\Private\Windows\LaunchWindows.cpp:137]
UATHelper: 打包 (HTML5):   LogWindows: Error: [Callstack] 0x00007ff7f516411d UE4Editor-Cmd.exe!LaunchWindowsStartup() [D:\Dev\UE-HTML5-4.27\Engine\Source\Runtime\Launch\Private\Windows\LaunchWindows.cpp:273]
UATHelper: 打包 (HTML5):   LogWindows: Error: [Callstack] 0x00007ff7f51754b4 UE4Editor-Cmd.exe!WinMain() [D:\Dev\UE-HTML5-4.27\Engine\Source\Runtime\Launch\Private\Windows\LaunchWindows.cpp:320]
UATHelper: 打包 (HTML5):   LogWindows: Error: [Callstack] 0x00007ff7f51773e2 UE4Editor-Cmd.exe!__scrt_common_main_seh() [D:\a\_work\1\s\src\vctools\crt\vcstartup\src\startup\exe_common.inl:288]
UATHelper: 打包 (HTML5):   LogWindows: Error: [Callstack] 0x00007ff919277374 KERNEL32.DLL!UnknownFunction []
UATHelper: 打包 (HTML5):   LogWindows: Error: [Callstack] 0x00007ff91a03cc91 ntdll.dll!UnknownFunction []
UATHelper: 打包 (HTML5):   LogWindows: Error:
UATHelper: 打包 (HTML5):   LogWindows: Error: end: stack for UAT
PackagingResults: Error: begin: stack for UAT
PackagingResults: Error: === Critical error: ===
PackagingResults: Error: Fatal error: [File:D:/Dev/UE-HTML5-4.27/Engine/Source/Runtime/Engine/Private/ShaderCompiler/ShaderCompiler.cpp] [Line: 6109]
PackagingResults: Error: Failed to compile global shader FHairCardsDeformationCS  .  Enable 'r.ShaderDevelopmentMode' in ConsoleVariables.ini for retries.
PackagingResults: Error: [Callstack] 0x00007ff917b4b699 KERNELBASE.dll!UnknownFunction []
PackagingResults: Error: [Callstack] 0x00007ff858fd4aa6 UE4Editor-Core.dll!ReportAssert() [D:\Dev\UE-HTML5-4.27\Engine\Source\Runtime\Core\Private\Windows\WindowsPlatformCrashContext.cpp:1644]
PackagingResults: Error: [Callstack] 0x00007ff858fd8b68 UE4Editor-Core.dll!FWindowsErrorOutputDevice::Serialize() [D:\Dev\UE-HTML5-4.27\Engine\Source\Runtime\Core\Private\Windows\WindowsErrorOutputDevice.cpp:78]
PackagingResults: Error: [Callstack] 0x00007ff858ce88ed UE4Editor-Core.dll!FOutputDevice::LogfImpl() [D:\Dev\UE-HTML5-4.27\Engine\Source\Runtime\Core\Private\Misc\OutputDevice.cpp:61]
PackagingResults: Error: [Callstack] 0x00007ff856239286 UE4Editor-Engine.dll!ProcessCompiledGlobalShaders() [D:\Dev\UE-HTML5-4.27\Engine\Source\Runtime\Engine\Private\ShaderCompiler\ShaderCompiler.cpp:6129]
PackagingResults: Error: [Callstack] 0x00007ff85623aba3 UE4Editor-Engine.dll!FShaderCompilingManager::ProcessCompiledShaderMaps() [D:\Dev\UE-HTML5-4.27\Engine\Source\Runtime\Engine\Private\ShaderCompiler\ShaderCompiler.cpp:3498]
PackagingResults: Error: [Callstack] 0x00007ff856238417 UE4Editor-Engine.dll!FShaderCompilingManager::ProcessAsyncResults() [D:\Dev\UE-HTML5-4.27\Engine\Source\Runtime\Engine\Private\ShaderCompiler\ShaderCompiler.cpp:4047]
PackagingResults: Error: [Callstack] 0x00007ff856241543 UE4Editor-Engine.dll!RecompileShadersForRemote() [D:\Dev\UE-HTML5-4.27\Engine\Source\Runtime\Engine\Private\ShaderCompiler\ShaderCompiler.cpp:6012]
PackagingResults: Error: [Callstack] 0x00007ff85302704d UE4Editor-UnrealEd.dll!UCookOnTheFlyServer::SaveGlobalShaderMapFiles() [D:\Dev\UE-HTML5-4.27\Engine\Source\Editor\UnrealEd\Private\CookOnTheFlyServer.cpp:5577]
PackagingResults: Error: [Callstack] 0x00007ff85302c5fb UE4Editor-UnrealEd.dll!UCookOnTheFlyServer::StartCookByTheBook() [D:\Dev\UE-HTML5-4.27\Engine\Source\Editor\UnrealEd\Private\CookOnTheFlyServer.cpp:6942]
PackagingResults: Error: [Callstack] 0x00007ff852e3ecb9 UE4Editor-UnrealEd.dll!UCookCommandlet::CookByTheBook() [D:\Dev\UE-HTML5-4.27\Engine\Source\Editor\UnrealEd\Private\Commandlets\CookCommandlet.cpp:966]
PackagingResults: Error: [Callstack] 0x00007ff852e696d8 UE4Editor-UnrealEd.dll!UCookCommandlet::Main() [D:\Dev\UE-HTML5-4.27\Engine\Source\Editor\UnrealEd\Private\Commandlets\CookCommandlet.cpp:663]
PackagingResults: Error: [Callstack] 0x00007ff7f5169c8a UE4Editor-Cmd.exe!FEngineLoop::PreInitPostStartupScreen() [D:\Dev\UE-HTML5-4.27\Engine\Source\Runtime\Launch\Private\LaunchEngineLoop.cpp:3434]
PackagingResults: Error: [Callstack] 0x00007ff7f5160d6d UE4Editor-Cmd.exe!GuardedMain() [D:\Dev\UE-HTML5-4.27\Engine\Source\Runtime\Launch\Private\Launch.cpp:132]
PackagingResults: Error: [Callstack] 0x00007ff7f51610fa UE4Editor-Cmd.exe!GuardedMainWrapper() [D:\Dev\UE-HTML5-4.27\Engine\Source\Runtime\Launch\Private\Windows\LaunchWindows.cpp:137]
PackagingResults: Error: [Callstack] 0x00007ff7f516411d UE4Editor-Cmd.exe!LaunchWindowsStartup() [D:\Dev\UE-HTML5-4.27\Engine\Source\Runtime\Launch\Private\Windows\LaunchWindows.cpp:273]
PackagingResults: Error: [Callstack] 0x00007ff7f51754b4 UE4Editor-Cmd.exe!WinMain() [D:\Dev\UE-HTML5-4.27\Engine\Source\Runtime\Launch\Private\Windows\LaunchWindows.cpp:320]
PackagingResults: Error: [Callstack] 0x00007ff7f51773e2 UE4Editor-Cmd.exe!__scrt_common_main_seh() [D:\a\_work\1\s\src\vctools\crt\vcstartup\src\startup\exe_common.inl:288]
PackagingResults: Error: [Callstack] 0x00007ff919277374 KERNEL32.DLL!UnknownFunction []
PackagingResults: Error: [Callstack] 0x00007ff91a03cc91 ntdll.dll!UnknownFunction []
PackagingResults: Error: end: stack for UAT
UATHelper: 打包 (HTML5): Took 28.2248723s to run UE4Editor-Cmd.exe, ExitCode=3
UATHelper: 打包 (HTML5): ERROR: Cook failed.
UATHelper: 打包 (HTML5):        (see D:\Dev\UE-HTML5-4.27\Engine\Programs\AutomationTool\Saved\Logs\Log.txt for full exception trace)
PackagingResults: Error: Cook failed.
UATHelper: 打包 (HTML5): AutomationTool exiting with ExitCode=25 (Error_UnknownCookFailure)
UATHelper: 打包 (HTML5): BUILD FAILED
PackagingResults: Error: Unknown Cook Failure
```

按照日志中的提示，找到引擎源码中的`Engine/Config/ConsoleVariables.ini`，将`r.ShaderDevelopmentMode=1`注释代码开启。重启编辑器进行打包，得到了更加详细的日志，弹窗如下：

```log
Compute sharders not supported for use in OpenGL.
```

![[Pasted image 20241023113704.png]]

注意看这里的`HairStrands`，这是一个ue的插件，其代码内部有shader相关资源，在其模块初始化时注册了自己的shader脚本，从而导致了打包h5失败。反向查找，发现`MeshModelingToolSet`插件依赖了这个插件，而`OpenZIAPI`插件又将`MeshModelingToolSet`插件开启了，故导致打包时只要放了`OpenZIAPI`插件就会失败。将`MeshModelingToolSet`插件禁用，打包通过！

## 空工程默认打包到HTML5运行报Uncaught ReferenceError: miniTempWebGLIntBuffers is not defined

```log
error: Uncaught ReferenceError: miniTempWebGLIntBuffers is not defined
showErrorDialog @ HtmlLite.UE4.js:970Understand this error
4c540dc5-5c73-4f47-9cd1-9bc19d093651:10 Uncaught ReferenceError: miniTempWebGLIntBuffers is not defined
    at _glUniform4iv (4c540dc5-5c73-4f47-9cd1-9bc19d093651:275289:14)
    at HtmlLite.wasm.FOpenGLShaderParameterCache::CommitPackedGlobals(FOpenGLLinkedProgram const*, int) (wasm://wasm/HtmlLite.wasm-2a6a2cf2)
    at HtmlLite.wasm.FOpenGLDynamicRHI::CommitNonComputeShaderConstantsSlowPath() (wasm://wasm/HtmlLite.wasm-2a6a2cf2)
    at HtmlLite.wasm.FOpenGLDynamicRHI::RHIDrawIndexedPrimitive(FRHIIndexBuffer*, int, unsigned int, unsigned int, unsigned int, unsigned int, unsigned int) (wasm://wasm/HtmlLite.wasm-2a6a2cf2)
    at HtmlLite.wasm.non-virtual thunk to FOpenGLDynamicRHI::RHIDrawIndexedPrimitive(FRHIIndexBuffer*, int, unsigned int, unsigned int, unsigned int, unsigned int, unsigned int) (wasm://wasm/HtmlLite.wasm-2a6a2cf2)
    at HtmlLite.wasm.FPixelShaderUtils::DrawFullscreenQuad(FRHICommandList&, unsigned int) (wasm://wasm/HtmlLite.wasm-2a6a2cf2)
    at HtmlLite.wasm.DrawRectangle(FRHICommandList&, float, float, float, float, float, float, float, float, FIntPoint, FIntPoint, TShaderRefBase<FShader, FShaderMapPointerTable> const&, EDrawRectangleFlags, unsigned int) (wasm://wasm/HtmlLite.wasm-2a6a2cf2)
    at HtmlLite.wasm.MobileReflectionEnvironmentCapture::ComputeAverageBrightness(FRHICommandListImmediate&, ERHIFeatureLevel::Type, int, float&) (wasm://wasm/HtmlLite.wasm-2a6a2cf2)
    at HtmlLite.wasm.FScene::UpdateSkyCaptureContents(USkyLightComponent const*, bool, UTextureCube*, FTexture*, float&, TSHVectorRGB<3>&, TArray<FFloat16Color, TSizedDefaultAllocator<32>>*) (wasm://wasm/HtmlLite.wasm-2a6a2cf2)
    at HtmlLite.wasm.USkyLightComponent::UpdateSkyCaptureContentsArray(UWorld*, TArray<USkyLightComponent*, TSizedDefaultAllocator<32>>&, bool) (wasm://wasm/HtmlLite.wasm-2a6a2cf2)Understand this error
HtmlLite.html:1 [.WebGL-000052E400116200] GL_INVALID_OPERATION: No defined conversion between clear value and attachment format.Understand this warning
```

