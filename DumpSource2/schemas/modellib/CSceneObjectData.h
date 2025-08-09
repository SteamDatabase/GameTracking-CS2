// MGetKV3ClassDefaults = {
//	"m_vMinBounds":
//	[
//		340282346638528859811704183484516925440.000000,
//		340282346638528859811704183484516925440.000000,
//		340282346638528859811704183484516925440.000000
//	],
//	"m_vMaxBounds":
//	[
//		-340282346638528859811704183484516925440.000000,
//		-340282346638528859811704183484516925440.000000,
//		-340282346638528859811704183484516925440.000000
//	],
//	"m_drawCalls":
//	[
//	],
//	"m_drawBounds":
//	[
//	],
//	"m_meshlets":
//	[
//	],
//	"m_vTintColor":
//	[
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000
//	]
//}
class CSceneObjectData
{
	Vector m_vMinBounds;
	Vector m_vMaxBounds;
	CUtlLeanVector< CMaterialDrawDescriptor > m_drawCalls;
	CUtlLeanVector< AABB_t > m_drawBounds;
	CUtlLeanVector< CMeshletDescriptor > m_meshlets;
	Vector4D m_vTintColor;
};
