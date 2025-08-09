// MGetKV3ClassDefaults = {
//	"vLocalMin":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"vLocalMax":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"flBounciness": 0.000000,
//	"nNode": 0,
//	"nCollisionMask": 65535,
//	"nVertexMapIndex": 65535,
//	"nFlags": 0,
//	"m_Distances":
//	[
//	],
//	"m_nWidth": 8,
//	"m_nHeight": 8,
//	"m_nDepth": 8
//}
class FeSDFRigid_t
{
	Vector vLocalMin;
	Vector vLocalMax;
	float32 flBounciness;
	uint16 nNode;
	uint16 nCollisionMask;
	uint16 nVertexMapIndex;
	uint16 nFlags;
	CUtlVector< float32 > m_Distances;
	int32 m_nWidth;
	int32 m_nHeight;
	int32 m_nDepth;
};
