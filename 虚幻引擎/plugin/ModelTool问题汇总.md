#ue #fbx #mesh #bug

导入的fbx模型，在UE编辑器中导入，进来的面片正常，显示为一个10米的正方形面片。但是用ModelTool导入的模型，放进场景后，有一个角缺失（少了一个三角面），推测是索引计算有误，丢失了最后一个索引。

![[Pasted image 20241011103321.png]]

查看代码，问题确实是索引有误，在`AIMesh`中，`GetStaticMesh`函数中，进行了前向遍历和反向遍历，用于构建双面？但是在其反向遍历时，代码如下：
```c++
		for (unsigned int Index = Mesh->mNumVertices - 1; Index > 0 ; Index--)
		{
			auto VertexID = MeshDescBuilder.AppendVertex(ToVector(Mesh->mVertices[Index]));

			auto Instance = MeshDescBuilder.AppendInstance(VertexID);
		}


		for (unsigned int i = Mesh->mNumFaces - 1; i > 0; i--)
		{
			const auto Face = Mesh->mFaces[i];
			if (Face.mNumIndices > 2)
			{
				MeshDescBuilder.AppendTriangle(VertexInstances[Face.mIndices[2]], VertexInstances[Face.mIndices[1]],
					VertexInstances[Face.mIndices[0]], PolygonGroup);
			}
		}
```

判断均是>0，且使用的索引变量类型为无符号类型。修改这里，解决问题：
```c++
		for (int Index = Mesh->mNumVertices - 1; Index >= 0 ; Index--)
		{
			auto VertexID = MeshDescBuilder.AppendVertex(ToVector(Mesh->mVertices[Index]));

			auto Instance = MeshDescBuilder.AppendInstance(VertexID);
		}


		for (int i = Mesh->mNumFaces - 1; i >= 0; i--)
		{
			const auto Face = Mesh->mFaces[i];
			if (Face.mNumIndices > 2)
			{
				MeshDescBuilder.AppendTriangle(VertexInstances[Face.mIndices[2]], VertexInstances[Face.mIndices[1]],
					VertexInstances[Face.mIndices[0]], PolygonGroup);
			}
		}
```