// MGetKV3ClassDefaults = {
//	"m_pChild":
//	{
//		"m_nodeIndex": -1
//	},
//	"m_bExclusiveRootMotion": 0,
//	"m_bExclusiveRootMotionFirstFrame": 0
//}
class CStateNodeStateData
{
	CAnimUpdateNodeRef m_pChild;
	bitfield:1 m_bExclusiveRootMotion;
	bitfield:1 m_bExclusiveRootMotionFirstFrame;
};
