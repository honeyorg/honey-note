原因：
因为`imgui-ts`当时解决了web端字体糊的问题，其解决方案是字体纹理的渲染不由imgui底层控制，而是由web端交由webgl自行渲染。

imgui中，通过调用`ImGui::SetWindowFontScale`可以设置当前窗口字体的缩放比例，函数实现如下：

```c++
void ImGui::SetWindowFontScale(float scale)
{
    IM_ASSERT(scale > 0.0f);
    ImGuiContext& g = *GImGui;
    ImGuiWindow* window = GetCurrentWindow();
    window->FontWindowScale = scale;
    g.FontSize = g.DrawListSharedData.FontSize = window->CalcFontSize();
}
```

可以看到，其设置了window的`FontWindowScale`属性，同时计算了`g.FontSize`。

在web端的字体渲染，逻辑走的是

```ts
async function font_update(io: ImGui.IO) {
    if (!dom_font) {
        dom_font = new Font;
    }
    io.Fonts.Fonts.forEach(font => {
        let glyph = font.GlyphToCreate;
        while (glyph) {
            glyph = dom_font.Create(glyph, font);
            font.GlyphCreated(glyph);
            glyph = font.GlyphToCreate;
        }
    });
    dom_font.UpdateTexture();
}
```

如果注释掉`while`循环体，则界面上一个字体都不会显示。因此可以考虑从while函数内部实现入手，看能否改进代码逻辑，实现web端的字体可以缩放的效果。

```ts
import { ImFont, ImFontGlyph } from './imgui'
import { Texture } from './imgui_impl'
import * as ImGui_Impl from './imgui_impl'

const FONT_SPACE=5;
const FONT_SIZE_EXTEND=2;

function GetFontName(font:ImFont):string
{
    return font.FontStyle + " " + font.FontSize + "px " + font.FontName;
}

export class TexturePage
{
    constructor(tex_size:number, font:ImFont)
    {
        this.FontName= GetFontName(font);
        this.Scale=ImGui_Impl.font_scale;
        this.TextureSize=tex_size;
        let font_size=font.FontSize;
        this.FontSize=font_size;
        this.SpaceX=font.SpaceX;
        this.FontImageSize=Math.ceil((font_size+FONT_SPACE)*this.Scale);
        this.Ascent=font.Ascent;
        this.Descent=font.Descent;

        this.PixelData=new Uint16Array(tex_size*tex_size);

        this.CharsPerRow=Math.floor(tex_size/this.FontImageSize);
        this.MaxCharCount=this.CharsPerRow*this.CharsPerRow;
        this.Current=0;
        if(!ImGui_Impl.gl)  {
            console.log("ImGui_Impl.gl is not ready")
            return;
        }
        let gl=ImGui_Impl.gl;
        this.Texure=new Texture();
        this.Texure._srcType=gl.UNSIGNED_SHORT_4_4_4_4;
        if(this.Scale==ImGui_Impl.canvas_scale) {
            this.Texure._minFilter=gl.NEAREST;
            this.Texure._magFilter=gl.NEAREST;
        }
        this.Texure.Update(this.PixelData, {width:tex_size, height:tex_size});
    }

    Destroy()
    {
        this.Texure.Destroy();
    }

    Create(glyph:ImFontGlyph, ctx: CanvasRenderingContext2D):ImFontGlyph {
        const image_size=this.FontImageSize;
        const cur=this.Current;
        this.Current++;
        const ix=cur%this.CharsPerRow;
        const iy=Math.floor(cur/this.CharsPerRow);
        const px=ix*(image_size);
        const py=iy*(image_size);
        const text=String.fromCharCode(glyph.Char);
        glyph.TextureID=this.Texure._texture;

        ctx.save();
        ctx.canvas.width=image_size;
        ctx.canvas.height=image_size;
        ctx.textAlign='left';
        ctx.textBaseline='top';
        ctx.font=this.FontName;
        ctx.clearRect(0,0,image_size,image_size);
        ctx.scale(this.Scale, this.Scale);
        let m=ctx.measureText(text);
        ctx.fillText(text, 1, 1);
        //ctx.strokeRect(0,0,image_size-FONT_SPACE, image_size-FONT_SPACE);
        ctx.restore();
        const img_data=ctx.getImageData(0,0,image_size, image_size);
        const img_data_u32=new Uint32Array(img_data.data.buffer);

        for(let y=0;y<image_size;y++)   {
            for(let x=0;x<image_size;x++)   {
                this.PixelData[(py+y)*this.TextureSize+px+x]=0xFFF0|
                (((img_data_u32[y*image_size+x]>>24)&0xFF)>>4);
            }
        }        
        let w=m.width<=this.FontSize?m.width:m.actualBoundingBoxRight-m.actualBoundingBoxLeft;
        if(glyph.Char==0)   {
            w=this.FontSize+1;
        }
        glyph.X0=0;
        glyph.Y0=this.Descent;
        glyph.X1=w+FONT_SIZE_EXTEND;
        glyph.Y1=this.FontSize+FONT_SIZE_EXTEND;
        glyph.AdvanceX=(w)+(glyph.Char<256?this.SpaceX[0]:this.SpaceX[1]);
        let uv_scale=1.0/(this.TextureSize);
        glyph.U0=(px)*uv_scale;
        glyph.V0=(py+this.Ascent*this.Scale)*uv_scale;
        glyph.U1=(px+glyph.X1*this.Scale)*uv_scale;
        glyph.V1=glyph.V0+(glyph.Y1*this.Scale)*uv_scale;

        this.Dirty=true;
        return glyph;
    }

    UpdateTexture() {
        this.Dirty=false;
        // console.log(this.FontName + " UpdateTexture " + this.Current + "/" + this.MaxCharCount);
        this.Texure.Update(this.PixelData);
    }

    get IsAvailable():boolean {return this.Current<this.MaxCharCount;}    

    FontName:string;
    Scale:number;
    TextureSize:number;
    FontSize:number;
    FontImageSize:number;
    PixelData:Uint16Array;
    Current:number;
    MaxCharCount:number;
    CharsPerRow:number;
    Texure:Texture;
    Dirty:boolean=false;
    SpaceX:number[];
    Ascent:number=0;
    Descent:number=0;
}

export class Font
{
    constructor()
    {
        let canvas=document.createElement("canvas");
        canvas.style.backgroundColor="transparent";
        canvas.style.position='absolute';
        canvas.style.top='0px';
        canvas.style.left='0px';
        canvas.style.borderWidth='0';
        canvas.style.borderStyle='none';
        canvas.style.pointerEvents='none';
        
        this.canvas=canvas;
        this.ctx=canvas.getContext("2d", {willReadFrequently:true}) as CanvasRenderingContext2D;
    }

    Destroy() {
        this.texturePage.forEach(page=>{
            page.Destroy();
        })
        this.texturePage=[];
    }

    Create(glyph: ImFontGlyph, font:ImFont):ImFontGlyph
    {
        let fontname=GetFontName(font);
        let page:TexturePage|null=null;
        for(let page2 of this.texturePage)   {
            if(page2.IsAvailable && page2.FontName==fontname)  {
                page=page2;
                break;
            }
        }
        if(!page)  {
            page=new TexturePage(512, font);
            this.texturePage.push(page);
        }
        this.canvas.width=font.FontSize;
        this.canvas.height=font.FontSize;
        this.dirty=true;
        return page.Create(glyph, this.ctx);
    }
    async UpdateTexture() {
        if(!this.dirty)
            return;
        // console.log("Font UpdateTexture begin");
        this.texturePage.forEach(page=>{
            if(page.Dirty)  {
                page.UpdateTexture();
            }
        })
        // console.log("Font UpdateTexture end");
        this.dirty=false;
    }

    texturePage:TexturePage[]=[];
    canvas: HTMLCanvasElement;
    ctx: CanvasRenderingContext2D;
    dirty:boolean=false;
}

```

`dom_font`是全局变量，仅有一份。该类为`Font`，管理了注册的所有字体。其中的`TexturePage`，指代的是，每一种字体，都对应一份`TexturePage`。

在`Font`类的`Create`函数中，设置了`this.canvas`的尺寸，`this.canvas`即指代单个字符的纹理大小。可以在这个地方入手试一下