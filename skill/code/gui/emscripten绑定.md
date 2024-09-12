 #ui  #ems  

[安装部署教程](https://www.codercto.com/a/59841.html)

基于ems在cpp中写绑定，再用emcc编译器将cpp编译成js文件，同步提供.d.ts文件，使ts侧可以调用接口

ems中绑定时，不要将const A* Var指针通过cosnt_cast<void*>(static_cast<const void*>(Var))转型为void*再传递给ems::val，否则web侧会出现Uncaught报红

在windows平台下，ems安装的环境变量要配置好，否则makefile中调用emcc会出错，makefile中的mkdir -p命令powershell不识别，可以用git bash


**Web端的WOFF2字体可以设置的style包括但不限于字体类型（‌font-family）‌、‌字体大小（‌font-size）‌、‌字体粗细（‌font-weight）‌、‌字体样式（‌font-style）‌、‌文本修饰线（‌text-decoration）‌、‌文本转换（‌text-transform）‌、‌字母间距（‌letter-spacing）‌、‌行高（‌line-height）‌、‌单词间距（‌word-spacing）‌、‌字体变体（‌font-variant）‌、‌字体拉伸（‌font-stretch）‌、‌字体大小调整（‌font-size-adjust）‌、‌字体平滑（‌font-smooth）‌、‌文本阴影（‌text-shadow）‌以及文本对齐方式（‌text-align）‌。‌**

这些属性提供了对Web字体的高度可定制性，‌允许开发者根据设计需求调整字体的各个方面，‌以达到最佳的视觉效果和用户体验。‌例如：‌

- **字体类型（‌font-family）‌**：‌用于指定字体的具体样式，‌如“微软雅黑”或其他自定义字体。‌
- **字体大小（‌font-size）‌**：‌直接决定了字体的显示尺寸，‌对于页面的整体布局和阅读体验至关重要。‌
- **字体粗细（‌font-weight）‌**：‌用于设置字体的粗细程度，‌如正常、‌加粗等，‌常用于标题或需要突出显示的文本。‌
- **字体样式（‌font-style）‌**：‌包括斜体和正常，‌用于增加文本的视觉层次感。‌
- **文本修饰线（‌text-decoration）‌**：‌如下划线、‌删除线等，‌用于添加额外的视觉效果。‌
- **文本对齐方式（‌text-align）‌**：‌包括左对齐、‌右对齐和居中对齐等，‌用于控制文本在容器内的水平对齐方式。‌

这些属性的综合运用，‌使得Web开发者能够灵活地控制字体的外观和行为，‌从而创造出丰富多样的网页视觉效果。‌