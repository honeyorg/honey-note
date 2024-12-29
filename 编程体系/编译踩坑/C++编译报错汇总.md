#cpp #cpp20 

[Implicit capture of ‘this’ via ‘[=]’ is deprecated in C++20](https://github.com/fmtlib/fmt/issues/1668)

lambda表达式中的捕获器，从C++20后不能只写`[=]`进行值捕获了，需要改写为`[=, this]`即可消除编译报错


