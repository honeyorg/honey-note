cpp_entity类对象存储了所有信息，如一个函数的函数签名，一个类的类名，一个命名空间，一个宏定义，一个类中的一条成员函数、成员变量等。demo中其通过code_generator类将数据以可读形式（字符串）缓存到了code_generator类的成员变量str中。因此想要支持代码生成，需要了解code_generator类的代码，自行封装一个custom_code_generator，将生成字符串改为生成绑定代码。


```c++
        class code_generator : public cppast::code_generator
        {
            std::string str_;                 // the result
            bool        was_newline_ = false; // whether or not the last token was a newline
            // needed for lazily printing them

        public:
            code_generator(const cppast::cpp_entity& e)
            {
                // kickoff code generation here
                cppast::generate_code(*this, e);
            }

            // return the result
            const std::string& str() const noexcept
            {
                return str_;
            }

        private:
            // called to retrieve the generation options of an entity
            generation_options do_get_options(const cppast::cpp_entity&,
                                              cppast::cpp_access_specifier_kind) override
            {
                // generate declaration only
                return code_generator::declaration;
            }

            // no need to handle indentation, as only a single line is used
            void do_indent() override {}
            void do_unindent() override {}

            // called when a generic token sequence should be generated
            // there are specialized callbacks for various token kinds,
            // to e.g. implement syntax highlighting
            void do_write_token_seq(cppast::string_view tokens) override
            {
                if (was_newline_)
                {
                    // lazily append newline as space
                    str_ += ' ';
                    was_newline_ = false;
                }
                // append tokens
                str_ += tokens.c_str();
            }

            // called when a newline should be generated
            // we're lazy as it will always generate a trailing newline,
            // we don't want
            void do_write_newline() override
            {
                was_newline_ = true;
            }

        } generator(e);
```

demo中，其继承`cppast::code_generator`派生自定义子类，构造中调用的`cppast::generate_code`是核心，其将`cpp_entity`的数据解析完毕后，通过`do_write_token_seq`回调函数将字符串放在了函数变量tokens中，之后函数实现里把结果存在了`str_`中，再通过`str()`返回出来。因此要自定义`generate_code`。

该函数实现为：
```c++
bool cppast::generate_code(code_generator& generator, const cpp_entity& e)
{
    generator.main_entity_ = type_safe::ref(e);
    auto result            = generate_code_impl(generator, e, cpp_public);
    generator.main_entity_ = nullptr;
    return result;
}
```

`generate_code_impl`，

```c++
bool generate_code_impl(code_generator& generator, const cpp_entity& e,
                        cpp_access_specifier_kind cur_access)
{
    switch (e.kind())
    {
#define CPPAST_DETAIL_HANDLE(Name)                                                                 \
    case cpp_entity_kind::Name##_t:                                                                \
        return generate_##Name(generator, static_cast<const cpp_##Name&>(e), cur_access);

        CPPAST_DETAIL_HANDLE(file)

        CPPAST_DETAIL_HANDLE(macro_parameter)
        CPPAST_DETAIL_HANDLE(macro_definition)
        CPPAST_DETAIL_HANDLE(include_directive)

        CPPAST_DETAIL_HANDLE(language_linkage)
        CPPAST_DETAIL_HANDLE(namespace)
        CPPAST_DETAIL_HANDLE(namespace_alias)
        CPPAST_DETAIL_HANDLE(using_directive)
        CPPAST_DETAIL_HANDLE(using_declaration)

        CPPAST_DETAIL_HANDLE(type_alias)

        CPPAST_DETAIL_HANDLE(enum)
        CPPAST_DETAIL_HANDLE(enum_value)

        CPPAST_DETAIL_HANDLE(class)
        CPPAST_DETAIL_HANDLE(access_specifier)
        CPPAST_DETAIL_HANDLE(base_class)

        CPPAST_DETAIL_HANDLE(variable)
        CPPAST_DETAIL_HANDLE(member_variable)
        CPPAST_DETAIL_HANDLE(bitfield)

        CPPAST_DETAIL_HANDLE(function_parameter)
        CPPAST_DETAIL_HANDLE(function)
        CPPAST_DETAIL_HANDLE(member_function)
        CPPAST_DETAIL_HANDLE(conversion_op)
        CPPAST_DETAIL_HANDLE(constructor)
        CPPAST_DETAIL_HANDLE(destructor)

        CPPAST_DETAIL_HANDLE(friend)

        CPPAST_DETAIL_HANDLE(template_type_parameter)
        CPPAST_DETAIL_HANDLE(non_type_template_parameter)
        CPPAST_DETAIL_HANDLE(template_template_parameter)

        CPPAST_DETAIL_HANDLE(alias_template)
        CPPAST_DETAIL_HANDLE(variable_template)
        CPPAST_DETAIL_HANDLE(function_template)
        CPPAST_DETAIL_HANDLE(function_template_specialization)
        CPPAST_DETAIL_HANDLE(class_template)
        CPPAST_DETAIL_HANDLE(class_template_specialization)
        CPPAST_DETAIL_HANDLE(concept)

        CPPAST_DETAIL_HANDLE(static_assert)

    case cpp_entity_kind::unexposed_t:
        return generate_unexposed(generator, static_cast<const cpp_unexposed_entity&>(e),
                                  cur_access);

#undef CPPAST_DETAIL_HANDLE

    case cpp_entity_kind::count:
        DEBUG_UNREACHABLE(detail::assert_handler{});
        break;
    }

    return false;
}
```

通过了一个宏定义简化了代码，不过代码跳转起来有一些费劲。在`code_generator.cpp`中，内部匿名命名空间中，定义了N多个`generate_##Name`的函数，这些函数就是解析cpp_entity然后返回字符串的核心代码了。

例如，`generate_function_parameter`代码如下：

```c++
bool generate_function_parameter(code_generator& generator, const cpp_function_parameter& param,
                                 cpp_access_specifier_kind cur_access)
{
    code_generator::output output(type_safe::ref(generator), type_safe::ref(param), cur_access);
    if (output)
        write_variable_base(output, param, param.name());
    return static_cast<bool>(output);
}
```

注意这些generate的第二个参数，每种类型有对应的cpp_##Name，这每一个类都是继承自`cpp_entity`的。
然后在内部，其构造一个`code_generator::output`，该`output`内部类，定义了`<<`操作符函数，会将每一次压入的字符串数据，通过`output`缓存的外部引用`generator`，调用其`do_write_token_seq`成员函数，以此实现了回调机制。

