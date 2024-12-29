 #puerts   #ue   #multithread  

ue中封装的委托可以供蓝图绑定ts 绑定的，要放在GameThread中调用，否则ts 回调触发不了，以及可能会导致v8崩溃。但是蓝图是没影响的