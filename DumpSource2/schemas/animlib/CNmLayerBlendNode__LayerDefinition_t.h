// MGetKV3ClassDefaults = {
//	"m_nInputNodeIdx": -1,
//	"m_nWeightValueNodeIdx": -1,
//	"m_nBoneMaskValueNodeIdx": -1,
//	"m_nRootMotionWeightValueNodeIdx": -1,
//	"m_bIsSynchronized": false,
//	"m_bIgnoreEvents": false,
//	"m_bIsStateMachineLayer": false,
//	"m_blendMode": "Overlay"
//}
class CNmLayerBlendNode::LayerDefinition_t
{
	int16 m_nInputNodeIdx;
	int16 m_nWeightValueNodeIdx;
	int16 m_nBoneMaskValueNodeIdx;
	int16 m_nRootMotionWeightValueNodeIdx;
	bool m_bIsSynchronized;
	bool m_bIgnoreEvents;
	bool m_bIsStateMachineLayer;
	NmPoseBlendMode_t m_blendMode;
};
