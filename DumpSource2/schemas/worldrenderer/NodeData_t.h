// MGetKV3ClassDefaults = {
//	"m_nParent": 0,
//	"m_vOrigin":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_vMinBounds":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_vMaxBounds":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_flMinimumDistance": 0.000000,
//	"m_ChildNodeIndices":
//	[
//	],
//	"m_worldNodePrefix": ""
//}
class NodeData_t
{
	int32 m_nParent;
	Vector m_vOrigin;
	Vector m_vMinBounds;
	Vector m_vMaxBounds;
	float32 m_flMinimumDistance;
	CUtlVector< int32 > m_ChildNodeIndices;
	CUtlString m_worldNodePrefix;
};
