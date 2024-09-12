 #cef   #browser  

– 要实现JS到C++的通信链，需要在BrowserProcess和RenderProcess两侧分别扩展接口。BrowserProcess中通过SendProcessMessage向RenderProcess发注册消息。RenderProcess通过OnProcessMessageReceived接收到消息后解析处理。如果要向JS注册变量及函数。需要用到CefV8Context来做桥接。

– 当在App层面的OnProcessMessageReceived触发时，判断如果是STARTUP，需要获取对端传来的所有持久绑定信息并进行缓存，否则下一次触发OnContextCreated时，上一次绑定的信息全会丢失

– 新增了renderer.h和[renderer.cc](http://renderer.cc)，并在CMakeLists中加入了这两个文件进行编译。同时修改client_**.cc使用新增的App类

– 为什么每点击一次按钮会重新加载网页？

– 因为点击按钮后，web调用了c++绑定的函数，函数执行完毕后会根据传递的CallbackId再回调到web。结果因为逻辑判断有问题，map中不包含id时取了id导致程序崩溃

– ue的guid如果生成数字型的字符串，是4个uint32转为16进制拼在一起的，且字符串为纯大写。对应的c++自封装代码可以参考如下：

```c++

#include <random>

#include <sstream>

#include <iomanip>

#include <cctype>

  

std::string GenerateRandomHexString() {

  std::random_device rd;

  std::mt19937 gen(rd());

  std::uniform_int_distribution<uint32_t> dis(0, UINT32_MAX);

  std::ostringstream ss;

  ss << std::hex << std::setw(8) << std::setfill(‘0’) << dis(gen)

     << std::hex << std::setw(8) << std::setfill(‘0’) << dis(gen)

     << std::hex << std::setw(8) << std::setfill(‘0’) << dis(gen)

     << std::hex << std::setw(8) << std::setfill(‘0’) << dis(gen);

  std::string result = ss.str();

  for (char& c : result) {

    c = std::toupper(c);

  }

  return result;

}
```

