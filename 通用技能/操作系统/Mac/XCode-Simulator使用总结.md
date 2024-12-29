#mac 
如果使用XCode新建了一个SwiftUI项目，运行时选择了iOS模拟器，那么会在macOS中看到一个应用程序Simulator。该程序位于XCode的Contents里面。是可以单独启动的，即不启动XCode只启动Simulator。

因为我的目的是了解这些流程，并将开发调试的工作迁移到VSCode中进行，所以必须知道构建、启动等流程等原理，才好进行VSCode的配置。

步骤分为几步吧

1. 启动Simulator，可以通过终端命令/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/Contents/MacOS/Simulator启动

2. 安装app，可以通过终端命令xcrun simctl install booted ~/Library/Developer/Xcode/DerivedData/Landmarks-avcqgblvttnafpccpsvpwnueonep/Build/Products/Debug-iphonesimulator/Landmarks.app

3. 启动app，可以通过终端命令xcrun simctl launch booted honey.Landmarks