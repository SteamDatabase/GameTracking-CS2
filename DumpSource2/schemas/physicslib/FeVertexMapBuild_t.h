// MGetKV3ClassDefaults = {
//	"m_VertexMapName": "",
//	"m_nNameHash": 0,
//	"m_Color":
//	[
//		255,
//		255,
//		255
//	],
//	"m_flVolumetricSolveStrength": 0.000000,
//	"m_nScaleSourceNode": -1,
//	"m_Weights":
//	[
//	]
//}
class FeVertexMapBuild_t
{
	CUtlString m_VertexMapName;
	uint32 m_nNameHash;
	Color m_Color;
	float32 m_flVolumetricSolveStrength;
	int32 m_nScaleSourceNode;
	CUtlVector< float32 > m_Weights;
};
