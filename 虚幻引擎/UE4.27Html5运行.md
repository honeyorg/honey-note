#ue #html5 #ems 
[[UE4.27Html5编译]] [[gdal插件Html5平台编译]]

```log
HtmlPro.UE4.js:134 Source map information is not available, emscripten_log with EM_LOG_C_STACK will be ignored. Build with "--pre-js $EMSCRIPTEN/src/emscripten-source-map.min.js" linker flag to add source map loading to code.
|   |   |   |   |
|---|---|---|---|
||Module.printErr|@|HtmlPro.UE4.js:134|
```

FTexture2DRHIRef SourceTextureRHI = SourceTexture->GetTexture2DResource()->TextureRHI;





没有设置`--pre-js ...`这个命令，而是通过观察源码，发现API插件的模块`Framework`中，依赖了一个`WebSocketNetworking`模块，该模块为引擎插件`WebSocketNetworking`的同名模块，其描述了该模块仅在PC端才能使用。但是为什么之前打包没失败就不知道原因了。

原因可能在这里：

![[Pasted image 20241025165209.png]]

官方自己写的要禁用所有的功能在H5平台

我这里改了`Framwwork`模块中关于ws依赖的代码，使用了平台宏进行条件编译。打包后再次运行，依然有模块加载失败，但是此次有了详细的日志，截取如下：
```log
[2024.10.25-08.37.49:871][  0]LogModuleManager: Warning: ModuleManager: Module 'UdpMessaging' not found - its StaticallyLinkedModuleInitializers function is null.

Assertion failed: Module [File:D:/Dev/UE-HTML5-4.27/Engine/Source/Runtime/Core/Private/Modules/ModuleManager.cpp] [Line: 359] 
UdpMessaging

...
```

可以看出`UdpMessaging`模块不支持在H5平台使用，继续查看源码

发现`DatasmithRuntime`依赖了`UdpMessaging`，那应该H5也用不了`DatasmithRuntime`了。同上，处理一下该模块依赖，仅在PC平台添加依赖。然后打包尝试，网页的控制台中仍然`mount WebSocketNetworking&DatasmithRuntime`，最终发现`API.uplugin`中设置了开启这两个插件。把
```json
{
  "Name": "WebSocketNetworking",
  "Enabled": true
},
{
  "Name": "DatasmithRuntime",
  "Enabled": true
}
```

删除！再次打包，我勒个豆，成功运行起来了！！！！！这下API插件的问题解决了，再次将GDAL插件放进来，打包，尝试运行

