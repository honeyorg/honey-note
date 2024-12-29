通过swift build和swift test命令，可以了解到这两个命令的用法。swift test会编译单元测试目标并运行测试用例。因为我当前创建的swift项目类型不是可执行程序而是库，因此能在VSCode调试对我而言就非常重要了。

此前尝试过一个项目中既有库目标又有可执行程序目标，但是配置起来相当复杂且没有打通，感觉是方向没对。后来了解到如果想在VSCode中调试单元测试代码，前置条件是需要用到XCode的xctest。

xctest是一个可执行程序，其可以追加参数来指示调试哪个测试。参数格式为填写一个*.xctest的路径。经查看发现*.xctest是一个文件夹。使用swift build —build-tests命令可以生成该文件夹。例如我的项目名为pony，其会在.build/debug下生成ponyPackageTests.xctest目录。此时尝试去配置tasks.json和launch.json。

tasks.json中添加：

{

  "label": "build test",

  "type": "shell",

  "command": "swift build -c debug --build-tests --skip-update",

  "problemMatcher": [],

  "group": {

    "kind": "build",

    "isDefault": false

  }

}

  

launch.json中添加：

{

  "configurations": [

    {

      "type": "lldb",

      "request": "launch",

      "sourceLanguages": [

        "swift"

      ],

      "cwd": "${workspaceFolder:pony}",

      "name": "Debug pony",

      "program": "/Applications/Xcode.app/Contents/Developer/usr/bin/xctest",

      "args": [

        ".build/debug/ponyPackageTests.xctest"

      ],

      "preLaunchTask": "build test"

    }

  ]

}