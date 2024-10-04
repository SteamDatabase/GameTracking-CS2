class ExtraVertexStreamOverride_t : public BaseSceneObjectOverride_t
{
	uint32 m_nSubSceneObject;
	uint32 m_nDrawCallIndex;
	MeshDrawPrimitiveFlags_t m_nAdditionalMeshDrawPrimitiveFlags;
	CRenderBufferBinding m_extraBufferBinding;
};
