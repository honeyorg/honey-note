```c++
ImGuiContext& g = *GImGui;
    ImStb::STB_TexteditState* stb_state = &state->Stb;
    ImStb::StbUndoState* undo_state = &stb_state->undostate;
    Text("ID: 0x%08X, ActiveID: 0x%08X", state->ID, g.ActiveId);
    DebugLocateItemOnHover(state->ID);
    Text("CurLenW: %d, CurLenA: %d, Cursor: %d, Selection: %d..%d", state->CurLenW, state->CurLenA, stb_state->cursor, stb_state->select_start, stb_state->select_end);
```

此前使用的`imgui-ts`虽然支持中文输入法，但其是通过在web端显示了一个`input`元素，并修改了imgui底层的`InputTextEx`函数实现，将当前的输入框的矩形区域缓存为了变量，并在web端获取该矩形区域，设置了`input`元素的尺寸和位置，达到`覆盖`在imgui原生输入框上面做的。

此方法取巧，存在一些问题。
1. 输入时的退出聚焦不是很好用
2. 如果存在输入时滚动区域，原生输入框已经不渲染了，但是该input还在网页中，且位置类似于`穿模`效果


故进行重构。

# 剪贴板总结

- 原生的不用改代码其实是支持的，但是有一些问题，就是剪切板功能，其实是UI内部的，即不能将内部文字粘贴到外部，也不能将外部复制的文本粘贴到内部，因此封装了代码实现该功能
- 另一个问题就是将复制粘贴的处理逻辑放置在了web端进行实现，在C++绑定侧提供了回调函数接口。web端将文本复制到剪切板，没有问题。但是如果粘贴时web端从剪贴板获取文本，其`clipboard.readText()`是一个异步函数，且该函数不能在web端没有进行点击等交互事件时触发，我根据`emsdk`文档尝试了在C++侧封装`js`异步接口。但是调用会报错，所以没有办法直接满足需求。
- 最终的方案是，如果鼠标移出了`canvas`，则重置原生ImGui当前激活的组件（例如文本框），同时取消聚焦文本输入框。然后当点击事件又进来，（即从外部复制了文本，又点击了UI文本框，此时会主动调用异步API缓存一次当前系统剪贴板中的最新数据），从而满足了需求。

# 输入框字符输入流程

在ImGui中，提供了`AddInputCharacter`接口，来向当前文本框中添加输入文字。

其会将字符封装在一个事件中，存放到一个事件队列。该事件队列由`UpdateInputEvents`调用取出元素，将字符从当前队列中，转存到`ImGuiIO::InputQueueCharacters`队列中。而这个io中的对列，由`InputTextEx`访问取出元素，将其添加到了`InputTextState`中。

`UpdateInputEvents`是唯一调用的，在`NewFrame`函数中。

 1. 某帧调用`AddInputCharacter`
 2. NewFrame -> UpdateInputEvents -> 将字符转存到io.InputQueueCharacters中
 3. InputTextEx -> 函数实现内部，将字符取出存在了state中，修改了state内部的`Stb`等数据

原生ImGui的输入法，Windows平台下，wish today，不是将当前输入法中的候选字符直接更新到InputText的Buf中，而是复盖在上面，由原生输入法的词条显示，直到选了候选词，才会将候选词整体通过`io.AddInputCharacter`压入InputText中。说实话有点垃圾了。

但是其定位当前InputText的光标位置倒是有解决方案，在`InputTextEx`实现中，将位置赋给了`g.PlatformImeData.InputPos`中。代码如下：
```c++
            if (!is_readonly)
            {
                g.PlatformImeData.WantVisible = true;
                g.PlatformImeData.InputPos = ImVec2(cursor_screen_pos.x - 1.0f, cursor_screen_pos.y - g.FontSize);
                g.PlatformImeData.InputLineHeight = g.FontSize;
            }
```

因此可以通过将`PlatformImeData`属性暴露到ts侧去访问，实现输入法定位！


[web端Composition文档](https://developer.mozilla.org/zh-CN/docs/Web/API/Element/compositionstart_event)

[web端监听输入法](https://cloud.tencent.com/developer/article/2344432)

`window.requestAnimationFrame` 方法，这是浏览器提供的用于动画和定时更新画面的方法，它比传统的 `setTimeout` 或 `setInterval` 更高效，因为它会根据浏览器的实际重绘时间来调度函数执行，从而减少不必要的计算。