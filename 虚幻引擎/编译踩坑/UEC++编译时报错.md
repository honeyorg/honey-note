#ue #build 

[# warning C4003: not enough arguments for function-like macro invocation 'max'](https://github.com/microsoft/cppwinrt/issues/479)

突然开始出这样的报错

```log
error C4003: not enough arguments for function-like macro invocation 'max'
error C4003: not enough arguments for function-like macro invocation 'max'
error C2589: '(': illegal token on right side of '::'
note: This diagnostic occurred in the compiler generated function 'std::optional<glm::dvec2> CesiumGltf::TexCoordFromAccessor::operator ()(const CesiumGltf::AccessorView<CesiumGltf::AccessorTypes::VEC2<T>> &)'
error C3878: syntax error: unexpected token '(' following 'expression'
note: This diagnostic occurred in the compiler generated function 'std::optional<glm::dvec2> CesiumGltf::TexCoordFromAccessor::operator ()(const CesiumGltf::AccessorView<CesiumGltf::AccessorTypes::VEC2<T>> &)'
note: error recovery skipped: '( ('
note: This diagnostic occurred in the compiler generated function 'std::optional<glm::dvec2> CesiumGltf::TexCoordFromAccessor::operator ()(const CesiumGltf::AccessorView<CesiumGltf::AccessorTypes::VEC2<T>> &)'
```

和参考链接中的问题类似。解决方案有两个

在Build.cs中添加了公有宏定义，问题解决！