 #swift   #build   #docc  

– swift help package init可查看具体命令参数

– swift package —allow-writing-to-directory ./docs generate-documentation —target pony可以在当前项目路径下生成指定target的DocC文档

– swift package —disable-sandbox preview-documentation —target pony可以预览生成的文档

– swift build —build-tests —skip-update可以编译测试target并生成/更新xctest，跳过更新可以缩短编译时间