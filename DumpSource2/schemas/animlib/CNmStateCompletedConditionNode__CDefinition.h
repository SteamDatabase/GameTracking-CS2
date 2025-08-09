// MGetKV3ClassDefaults = {
//	"_class": "CNmStateCompletedConditionNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nSourceStateNodeIdx": -1,
//	"m_nTransitionDurationOverrideNodeIdx": -1,
//	"m_flTransitionDurationSeconds": 0.000000
//}
class CNmStateCompletedConditionNode::CDefinition : public CNmBoolValueNode::CDefinition
{
	int16 m_nSourceStateNodeIdx;
	int16 m_nTransitionDurationOverrideNodeIdx;
	float32 m_flTransitionDurationSeconds;
};
