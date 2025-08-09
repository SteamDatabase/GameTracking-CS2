// MGetKV3ClassDefaults = {
//	"_class": "CNmAnimationPoseNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nPoseTimeValueNodeIdx": -1,
//	"m_nDataSlotIdx": -1,
//	"m_inputTimeRemapRange":
//	{
//		"m_flMin": 0.000000,
//		"m_flMax": 1.000000
//	},
//	"m_flUserSpecifiedTime": 0.000000,
//	"m_bUseFramesAsInput": false
//}
class CNmAnimationPoseNode::CDefinition : public CNmPoseNode::CDefinition
{
	int16 m_nPoseTimeValueNodeIdx;
	int16 m_nDataSlotIdx;
	Range_t m_inputTimeRemapRange;
	float32 m_flUserSpecifiedTime;
	bool m_bUseFramesAsInput;
};
