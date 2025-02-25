
做一款截图插件，借鉴Snipaste的功能，在UE中进行实现。

目的是方便快速在UE中截取UE场景的图片并做一些标注。当然，Snipaste也能做这些事情。


```c++
// 在Unreal Engine中，截图的工作原理如下：
// 1. 调用 FScreenshotRequest::RequestScreenshot 请求系统拍摄一张截图。截图的分辨率将与当前视口相同；
// 2. 注册一个回调到 UGameViewportClient::OnScreenshotCaptured() 委托。当截图拍摄完成后，回调函数将被调用，并传递截图的像素数据；
// 3. 等待下一帧或调用 FSceneViewport::Invalidate 强制重绘。截图不会在当前帧拍摄，而是在下一帧的重绘过程中通过 UGameViewportClient::ProcessScreenshots 或 FEditorViewportClient::ProcessScreenshots 从视口中读取像素数据，并触发步骤2中注册的回调函数。
```

