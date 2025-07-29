// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
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
