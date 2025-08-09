// MGetKV3ClassDefaults = {
//	"m_nSceneObjectIndex": 0,
//	"m_nSubSceneObject": 0,
//	"m_nDrawCallIndex": 0,
//	"m_nAdditionalMeshDrawPrimitiveFlags": "MESH_DRAW_FLAGS_NONE",
//	"m_extraBufferBinding":
//	{
//		"m_hBuffer": 0,
//		"m_nBindOffsetBytes": 0
//	}
//}
class ExtraVertexStreamOverride_t : public BaseSceneObjectOverride_t
{
	uint32 m_nSubSceneObject;
	uint32 m_nDrawCallIndex;
	MeshDrawPrimitiveFlags_t m_nAdditionalMeshDrawPrimitiveFlags;
	CRenderBufferBinding m_extraBufferBinding;
};
