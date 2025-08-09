// MGetKV3ClassDefaults = {
//	"_class": "CNmIDEventConditionNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nSourceStateNodeIdx": -1,
//	"m_eventConditionRules":
//	{
//		"m_flags": 0
//	},
//	"m_eventIDs":
//	[
//	]
//}
class CNmIDEventConditionNode::CDefinition : public CNmBoolValueNode::CDefinition
{
	int16 m_nSourceStateNodeIdx;
	CNmBitFlags m_eventConditionRules;
	CUtlVectorFixedGrowable< CGlobalSymbol, 5 > m_eventIDs;
};
