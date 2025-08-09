// MGetKV3ClassDefaults = {
//	"_class": "CNmFootstepEventPercentageThroughNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nSourceStateNodeIdx": -1,
//	"m_phaseCondition": "LeftFootDown",
//	"m_eventConditionRules":
//	{
//		"m_flags": 0
//	}
//}
class CNmFootstepEventPercentageThroughNode::CDefinition : public CNmFloatValueNode::CDefinition
{
	int16 m_nSourceStateNodeIdx;
	NmFootPhaseCondition_t m_phaseCondition;
	CNmBitFlags m_eventConditionRules;
};
