#puerts #ue 
# 实时监视代码变更

在要创建`puerts::FJsEnv`的类中，添加如下代码：
```c++
// .h
#if WITH_EDITOR
#include "SourceFileWatcher.h"
#endif

#if WITH_EDITOR
	TSharedPtr<puerts::FSourceFileWatcher> SourceFileWatcher;
#endif

// .cpp
// 原来是：JsEnv = MakeShared<puerts::FJsEnv>(std::make_unique<puerts::DefaultJSModuleLoader>(TEXT("JavaScript")), std::make_shared<puerts::FDefaultLogger>(), DebugPort);
// 改成
#if WITH_EDITOR
	bool bWatchDisable = true;
	GConfig->GetBool(SectionName, TEXT("WatchDisable"), bWatchDisable, PuertsConfigIniPath);
	if (bWatchDisable) {
		JsEnv = MakeShared<puerts::FJsEnv>(std::make_unique<puerts::DefaultJSModuleLoader>(TEXT("JavaScript")), std::make_shared<puerts::FDefaultLogger>(), DebugPort);
	} else {
		SourceFileWatcher = MakeShared<puerts::FSourceFileWatcher>(
		[this](const FString& InPath)
		{
			if (JsEnv.IsValid())
			{
				TArray<uint8> Source;
				if (FFileHelper::LoadFileToArray(Source, *InPath))
				{
					JsEnv->ReloadSource(InPath, std::string((const char*) Source.GetData(), Source.Num()));
				}
				else
				{
					UE_LOG(Puerts, Error, TEXT("read file fail for %s"), *InPath);
				}
			}
		});
		JsEnv = MakeShared<puerts::FJsEnv>(std::make_unique<puerts::DefaultJSModuleLoader>(TEXT("JavaScript")), std::make_shared<puerts::FDefaultLogger>(), DebugPort,
		[this](const FString& InPath)
		{
			if (SourceFileWatcher.IsValid())
			{
				SourceFileWatcher->OnSourceLoaded(InPath);
			}
		});
	}
#else
	JsEnv = MakeShared<puerts::FJsEnv>(std::make_unique<puerts::DefaultJSModuleLoader>(TEXT("JavaScript")), std::make_shared<puerts::FDefaultLogger>(), DebugPort);
#endif
```

同时，因为访问了`DefaultPuerts.ini`文件中的`WatchDisable`属性，因此需要去项目的`Config`中找到该ini文件将`WatchDisable`改为`False`

从代码中可以看到，加了`#if WITH_EDITOR`，原因是如果不加，则打包时会报错。源码监视不能在Runtime下使用，加上后打包流程就不会因为监视脚本代码而报错了。

# 多个JsEnv调试冲突解决办法

原因是创建的多个`JsEnv`都监听了相同的`DebugPort`。所以只有先创建的能监听到，调试时能绑定到。

1. 要么改成多端口的
2. 要么只对想调试的`JsEnv`调用`WaitDebugger`

# 修改启动脚本位置

在`DefaultPuerts.ini`中，有一个`StartScript=Scripts/PathYourStartScript`，修改这里即可。启动时EntryPoint就是该脚本。其起始路径/根路径为项目的`Content/JavaScript/`

# VSCode调试

`.vscode`文件夹中，定义一个编译ts用的文件和一个调试ts用的文件
```json
// launch.json
{
	"version": "0.2.0",
	"configurations": [
		{
			"type": "node",
			"request": "attach",
			"name": "Attach",
			"port": 8081,
			"sourceMaps": true,
			"resolveSourceMapLocations": [
				"${workspaceFolder}/../Content/JavaScript/**",
				"!${workspaceFolder}/../**/node_modules/**"
			],
		}
	]
}

// tasks.json
{
	"version": "2.0.0",
	"tasks": [
		{
			"type": "typescript",
			"tsconfig": "tsconfig.json",
			"option": "watch",
			"problemMatcher": [
				"$tsc-watch"
			],
			"group": "build",
			"label": "tsc: 监视 - tsconfig.json"
		}
	]
}
```

请注意这里的`resolveSourceMapLocations`。我的工程目录结构为：
```
- Content
  - JavaScript
    - Scripts
      - TSSource // outDir在这里
- Plugins
- Source
- TSSource
  - .vscode
  - tsconfig.json
- *.uproject
```

在我的vscode工作区，即和`*.code-workspace`文件同级，有一个`tsconfig.json`，内容如下：

```json
// tsconfig.json
{
    "compilerOptions": {
        "target": "esnext",
        "module": "CommonJS",
        "experimentalDecorators": true,
        "emitDecoratorMetadata": true,
        "moduleResolution": "Node",
        "jsx": "react",
        "sourceMap": true,
        "skipLibCheck": true,
        "rootDir": "./../",
        "typeRoots": [
            "../Plugins/Puerts/Typing",
            "../node_modules/@types"
        ],
        "outDir": "../Content/JavaScript/Scripts"
    },
    "include": [
        "../TSProject/**/*",
        // "../Plugins/**/*"
    ],
    "exclude": [
        "../**/*.d.ts",
        "../Plugins/Puerts/**/*.ts"
    ]
}
```

注意这里的`rootDir`、`outDir`、`include`等路径
