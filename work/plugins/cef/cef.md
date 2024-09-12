## cefclient粘贴问题

问题描述：

Linux平台下，当从任意外部应用程序复制文字到剪贴板，或者直接从cefclient的gtk构建的工具栏中的地址输入栏中复制文字。再到网页中进行粘贴时，程序阻塞大概30秒，然后粘贴未生效

解决办法：

是一个cef的已知问题，目前好像仍没有修复，但是可以规避。

参考链接：https://github.com/chromiumembedded/cef/issues/3117

已尝试，管用，但是不够用...如果我是在代码中将CefSettings中的`multi_threaded_message_loop`设置为true，并不能生效。只能通过参考链接中提供的方法，使用命令行参数的形式才能生效。

Cef功能开发经验总结：http://www.360doc.com/content/17/0706/17/9200790_669368947.shtml