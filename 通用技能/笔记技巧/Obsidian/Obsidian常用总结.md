#obsidian 
## Callout语法

### 基本使用

```text
> [!NOTE]+/-(控制默认折叠模式，不加则不可以折叠) Title
> Content
```


分为四个部分：

- 开头的 >
- 标明 callout 类型的 NOTE
- callout 的标题 Title
- callout 的正文 Content

obsidian 共提供了 13 种 callout

- 他们是大小写不敏感的，例如 `> [!BUG]`,`> [!bug]` 和 `> [!Bug]` 的效果是一样的；
- 同一类型的 callout 可能有很多种别名，例如 `> [!info]` 和 `> [!todo]` 的样式是一样的；  
    
- note
- abstract, summary, tldr
- info
- todo
- tip, hint, important
- success, check, done
- question, help, faq
- warning, caution, attention
- failure, fail, missing
- danger, error
- bug
- example
- quote, cite

### 效果预览

> [!note]+ 这是note callout
> 这里是内容

> [!abstract]+ 这是abstract callout
> 这里是内容

> [!info]+ 这是info callout
> 这里是内容

> [!todo]+ 这是todo callout
> 这里是内容

> [!tip]+ 这是tip callout
> 这里是内容

> [!success]+ 这是success callout
> 这里是内容

> [!question]+ 这是question callout
> 这里是内容

> [!warning]- 这是warning callout
> 这里是内容
> asd
> asd
> asd
> asd
> asd
> asd

> [!failure]- 这是failure callout
> 这里是内容

> [!error]- 这是error callout
> 这里是内容

> [!bug]- 这是bug callout
> 这里是内容

> [!example]- 这是example callout
> 这里是内容

> [!quote]- 这是quote callout
> 这里是内容