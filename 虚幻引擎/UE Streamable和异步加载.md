[dev.epicgames.com/documentation/zh-cn/unreal-engine/asynchronous-asset-loading-in-unreal-engine](https://dev.epicgames.com/documentation/zh-cn/unreal-engine/asynchronous-asset-loading-in-unreal-engine)

针对资源加载的优化方案，异步加载需要传入StringReference的资源路径，由全局Streamable调用RequestAsyncLoad完成加载，且可以传递回调函数，用于加载完毕后的处理