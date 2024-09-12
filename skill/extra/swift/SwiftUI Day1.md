 #ui   #swift  

– 学习了SwiftUI的声明式UI语法，比较类似UE的Slate，都是以链式结构来设置属性的

– Stack代表了基础容器，HStack，VStack，ZStack分别对应了水平框、垂直框和前后框

– Text有很多属性，可以设置字体，颜色，多行文本对齐方式，多行文本限制数（若字数超过框内区域，会自动追加…）

– Image可以通过使用systemName来设置基础图标，也可以通过设置已导入图片资源的名称来设置图片内容，同时还可以设置样式为圆形，设置Overlay+stroke以追加边框，shadow可以设置阴影半径等

– MapKit模块导入后，可以设置地图，可以设置地图的中心点以及Delta。同时在View中声明Map组件给初始坐标

– 导入的图片资源假如命名为picture@2x.png，则导入后资源列表中会显示picture命名的图片资源，其包含1x、2x、3x三个尺寸图片，直接会赋值给2x图片，对应的Content.json中也会把2x属性字段的值进行修改，添加filename属性

– Stack是可以设置padding的，但是目前还没有掌握每个边（顶底左右）各自的padding，只能通过统一设置为一个值来实现等距边界填充