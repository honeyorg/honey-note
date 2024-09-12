[dev.epicgames.com/documentation/zh-cn/unreal-engine/referencing-assets-in-unreal-engine](https://dev.epicgames.com/documentation/zh-cn/unreal-engine/referencing-assets-in-unreal-engine)

直接引用资产，代码简单，但是会出现加载时直接生成的逻辑，即可能会导致初始化时内存暴涨。

如需优化性能，可以使用软引用的方式。如果资产过多或者资产过大导致加载时游戏线程帧率过低，可以结合异步加载