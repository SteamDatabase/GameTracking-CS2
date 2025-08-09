// MGetKV3ClassDefaults = {
//	"m_Name": "",
//	"m_nMeshIndex": -1,
//	"m_nDataBlock": -1,
//	"m_nMorphBlock": -1,
//	"m_vertexBuffers":
//	[
//	],
//	"m_indexBuffers":
//	[
//	],
//	"m_toolsBuffers":
//	[
//	],
//	"m_nVBIBBlock": -1,
//	"m_nToolsVBBlock": -1
//}
class ModelEmbeddedMesh_t
{
	CUtlString m_Name;
	int32 m_nMeshIndex;
	int32 m_nDataBlock;
	int32 m_nMorphBlock;
	CUtlVector< ModelMeshBufferData_t > m_vertexBuffers;
	CUtlVector< ModelMeshBufferData_t > m_indexBuffers;
	CUtlVector< ModelMeshBufferData_t > m_toolsBuffers;
	int32 m_nVBIBBlock;
	int32 m_nToolsVBBlock;
};
