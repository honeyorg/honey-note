#electron 

# 项目创建

1. `npm init`初始化项目，生成`package.json`
2. `npm install electron --save-dev`，安装electron模块在当前项目中
3. 创建main.js，写入口函数
4. 写html，定义窗口内容

# 打包

1. `npm install @electron-forge/cli --save-dev`，安装forge模块在当前项目中
2. `npx electron-forge import`，设置forge的脚手架，该步骤会检查依赖，补充依赖等。结束后会修改`package.json`，其中的`scrpits`中会多出来几个命令，
3. 使用`npm run make`，调用forge的打包命令，会在当前目录的`out`目录生成可执行程序