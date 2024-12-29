# Overview

This is a ui plugin that provides some generic ui components. Currently, this includes a stitching UI component, and there are plans to provide a variety of common UI components, such as scroll unrolling components, 3D bar charts, 3D pie charts, etc.


## StitchedImage

The stitching image component is used to stitch two textures of the same size into one texture. The stitched texture is rendered according to parameters such as anchors and angles. Of course, it supports some mouse interaction. When the mouse enters the region of stitching image A, the stitching image will move the splitter line in the form of animation until the stitching image is completely rendered as image A. Similarly, when the mouse enters the area of stitched image B, it will move in the opposite direction to present the complete image B.

### Parameter Description

- `TextureA`: Texture A to be stitched
- `TextureB`: Texture B to be stitched
- `CenterPivot`: The pivot point of the partition line on the stitched texture. For example, (0.5, 0.5) represents the center point
- `Angle`: The rotation Angle of the split line, ranging from 0 to 360, with positive values being clockwise along the positive X-axis
- `MoveSeconds`: The animation duration of the stitched image after the mouse is hovered, in seconds. If 1s is filled in, it means that the stitched image becomes texture A or texture B completely after 1 second

### Preview

TextureA

![[Light.png]]

TextureB

![[Dark.png]]

Situation one: `CenterPivot=(0.5, 0.5), Angle=(45)`

![[Pasted image 20241214163628.png]]

Situation two: `CenterPivot=(0.3, 0.5), Angle=(90)`

![[Pasted image 20241214163739.png]]

Situation three: `CenterPivot=(0.5, 0.5), Angle=(0)`

![[Pasted image 20241214163850.png]]

In umg blueprint editor:

![[Pasted image 20241214164004.png]]