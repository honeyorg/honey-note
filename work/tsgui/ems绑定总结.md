[Embind官方文档](https://emscripten.org/docs/porting/connecting_cpp_and_javascript/embind.html#embind)

```c++
// person.h 
struct Person { 
  std::string name;
  int age;
  Person(const std::string& name, int age) : name(name), age(age) {}
  void sayHello() {
    std::cout << "Hello, my name is " << name << " and I am " << age << " years old." << std::endl;
  } 
  // 重载函数
  void sayHello(const std::string& message) {
    std::cout << "Hello, " << message << std::endl;
  }
};
```

```c++
// person_binding.cpp
#include <emscripten/bind.h>
#include "person.h"
using namespace emscripten;
EMSCRIPTEN_BINDINGS(person) {
  class_<Person>("Person")
    .constructor<std::string&, int>()
    .property("name", &Person::name)
    .property("age", &Person::age)
    .function("sayHello", &Person::sayHello)
    .function("sayHello", pure_virtual(&Person::sayHello)); // 绑定重载函数
    // 如果有需要，可以在这里添加更多的绑定细节
}
```

### Custom `val` Definitions

`emscripten::val` types are mapped to TypeScript’s any type by default, which does not provide much useful information for API’s that consume or produce val types. To give better type information, custom val types can be registered using `EMSCRIPTEN_DECLARE_VAL_TYPE()` in combination with `emscripten::register_type`. An example below:

```c++
EMSCRIPTEN_DECLARE_VAL_TYPE(CallbackType);
int function_with_callback_param(CallbackType ct) {
    ct(val("hello"));
    return 0;
}
EMSCRIPTEN_BINDINGS(custom_val) {
    function("function_with_callback_param", &function_with_callback_param);
    register_type<CallbackType>("(message: string) => void");
}
```

## Memory views

In some cases it is valuable to expose raw binary data directly to JavaScript code as a typed array, allowing it to be used without copying. This is useful for instance for uploading large WebGL textures directly from the heap.

Memory views should be treated like raw pointers; lifetime and validity are not managed by the runtime and it’s easy to corrupt data if the underlying object is modified or deallocated.

```c++
#include <emscripten/bind.h>
#include <emscripten/val.h>

using namespace emscripten;
unsigned char *byteBuffer = /* ... */;
size_t bufferLength = /* ... */;
val getBytes() {
    return val(typed_memory_view(bufferLength, byteBuffer));
}
EMSCRIPTEN_BINDINGS(memory_view_example) {
    function("getBytes", &getBytes);
}
```

The calling JavaScript code will receive a typed array view into the emscripten heap:

```js
var myUint8Array = Module.getBytes()
var xhr = new XMLHttpRequest();
xhr.open('POST', /* ... */);
xhr.send(myUint8Array);
```

The typed array view will be of the appropriate matching type, such as Uint8Array for an `unsigned char` array or pointer.



# WASM断点调试C++

[操作文档](https://cloud.tencent.com/developer/article/1811522)

