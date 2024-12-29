[虚幻引擎中的接口 | 虚幻引擎 5.4 文档 | Epic Developer Community](https://dev.epicgames.com/documentation/zh-cn/unreal-engine/interfaces-in-unreal-engine)

  

UINTERFACE

class UXXInterface : public UInterface

空类

  

class IXXInterface

实现具体接口，如需蓝图调用，则不能用virtual修饰且必须BlueprintNativeEvent和Implement选一个，不能只有BlueprintCallable。虽为借口类，但可以提供默认实现，即不强制要求声明为= 0的纯虚函数