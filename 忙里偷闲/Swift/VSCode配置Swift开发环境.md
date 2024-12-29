 #swift   #vscode  

– 安装Swift插件

– 因为已经有了XCode，内置了sourcekit-lsp，因此无需按照网上的教程自行下载编译配置路径等，Swift插件配置中的lsp路径也无需自行填写，默认留空，插件能找到lsp

– 插件的依赖中默认配置了CodeLLDB，因此也无需自行下载该插件，会同时下载下来

– 然后在终端通过命令行来创建一个基础Swift项目

– swift package init —type executable

– 之后用VSCode打开该项目，会发现自动配置了launch.json，但是没有配置tasks.json，可以自行配置

– tasks很简单，label和launch中的对应，type是shell，command是swift build -c debug