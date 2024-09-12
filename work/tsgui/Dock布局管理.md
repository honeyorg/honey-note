[[功能列表]]

在`ImGuiContextManager.cpp`中，有以下代码：
```c++
void FImGuiContextManager::OnWorldTickStart(UWorld* World, ELevelTick TickType, float DeltaSeconds)
{
	if (World && (World->WorldType == EWorldType::Game || World->WorldType == EWorldType::PIE
		|| World->WorldType == EWorldType::Editor))
	{
		FImGuiContextProxy& ContextProxy = GetWorldContextProxy(*World);

		// Set as current, so we have right context ready when updating world objects.
		ContextProxy.SetAsCurrent();

		ContextProxy.DrawEarlyDebug();
#if !ENGINE_COMPATIBILITY_WITH_WORLD_POST_ACTOR_TICK
		ContextProxy.DrawDebug();
#endif
	}
}
```

发现当为Editor时也会进入，结果调用了`GetWorldContextProxy`，构造了Proxy，随之就是imgui的`DockContextInitialize`被调用了，函数内部创建了一个新的`ini_handler`，并且放入了`g.SettingHandlers`中

这里其实不是影响在PIE模式下反复启动，`PIEContext*.ini`中的`[Docking][Data]`数据未清空且累加的原因！

解决方案：（已测试通过）
在`UIDockManager.ts`中，初始化时调用

```ts
ImGuiInternal.DockBuilderRemoveNodeDockedWindows(0)
ImGuiInternal.DockBuilderRemoveNodeChildNodes(0)
```

其中传入的dockid为0，即清空所有的dock信息。等待同步时刻到来时，`PIEContext*.ini`中的`[Docking][Data]`只会存在一个DockSpace信息，问题解决！

