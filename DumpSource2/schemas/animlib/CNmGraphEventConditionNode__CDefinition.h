// MGetKV3ClassDefaults = {
//	"_class": "CNmGraphEventConditionNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nSourceStateNodeIdx": -1,
//	"m_eventConditionRules":
//	{
//		"m_flags": 0
//	},
//	"m_conditions":
//	[
//	]
//}
class CNmGraphEventConditionNode::CDefinition : public CNmBoolValueNode::CDefinition
{
	int16 m_nSourceStateNodeIdx;
	CNmBitFlags m_eventConditionRules;
	CUtlVectorFixedGrowable< CNmGraphEventConditionNode::Condition_t, 5 > m_conditions;
};
