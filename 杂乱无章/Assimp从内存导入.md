#assimp #fbx #model #asset #import 

[Assimp文档](https://documentation.help/assimp/index.html)

# 接口

```c++
//cimport.h

/** Reads the given file from a given memory buffer,  
 * * If the call succeeds, the contents of the file are returned as a pointer to an * aiScene object. The returned data is intended to be read-only, the importer keeps * ownership of the data and will destroy it upon destruction. If the import fails, * NULL is returned. * A human-readable error description can be retrieved by calling aiGetErrorString(). * @param pBuffer Pointer to the file data * @param pLength Length of pBuffer, in bytes * @param pFlags Optional post processing steps to be executed after *   a successful import. Provide a bitwise combination of the *   #aiPostProcessSteps flags. If you wish to inspect the imported *   scene first in order to fine-tune your post-processing setup, *   consider to use #aiApplyPostProcessing(). * @param pHint An additional hint to the library. If this is a non empty string, *   the library looks for a loader to support the file extension specified by pHint *   and passes the file to the first matching loader. If this loader is unable to *   completely the request, the library continues and tries to determine the file *   format on its own, a task that may or may not be successful. *   Check the return value, and you'll know ... * @return A pointer to the imported data, NULL if the import failed. * * @note This is a straightforward way to decode models from memory * buffers, but it doesn't handle model formats that spread their * data across multiple files or even directories. Examples include * OBJ or MD3, which outsource parts of their material info into * external scripts. If you need full functionality, provide * a custom IOSystem to make Assimp find these files and use * the regular aiImportFileEx()/aiImportFileExWithProperties() API. */ASSIMP_API const C_STRUCT aiScene *aiImportFileFromMemory(  
        const char *pBuffer,  
        unsigned int pLength,  
        unsigned int pFlags,  
        const char *pHint);
```

注意文档中说明的`pHint`参数的作用。

我这里默认给了`nullptr`，按文档说法会尝试自动解析内存数据的文件格式，我传入的是`fbx`类型的文件内存数据，结果得到的返回值`aiScene*`是空指针，我使用`aiGetErrorString`接口获取了一下错误信息，说的是：

```log
No suitable reader found for the file format of file "$$$___magic___$$$.".
```

随后我又尝试`pHint`赋值了`fbx`，可以正常解析了。

