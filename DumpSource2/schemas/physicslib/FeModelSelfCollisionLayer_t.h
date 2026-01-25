// MGetKV3ClassDefaults = {
//	"m_Name": "",
//	"m_Nodes":
//	[
//	],
//	"m_flParentReaction": 0.000000,
//	"m_nFlags": 0,
//	"m_nEndIdx":
//	[
//		0,
//		0,
//		0,
//		0
//	]
//}
class FeModelSelfCollisionLayer_t
{
	CUtlString m_Name;
	CUtlVector< uint16 > m_Nodes;
	float32 m_flParentReaction;
	uint32 m_nFlags;
	uint32[4] m_nEndIdx;
};
