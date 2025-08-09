// MGetKV3ClassDefaults = {
//	"_class": "CNmFootEventConditionNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nSourceStateNodeIdx": -1,
//	"m_phaseCondition": "LeftFootDown",
//	"m_eventConditionRules":
//	{
//		"m_flags": 0
//	}
//}
class CNmFootEventConditionNode::CDefinition : public CNmBoolValueNode::CDefinition
{
	int16 m_nSourceStateNodeIdx;
	NmFootPhaseCondition_t m_phaseCondition;
	CNmBitFlags m_eventConditionRules;
};
