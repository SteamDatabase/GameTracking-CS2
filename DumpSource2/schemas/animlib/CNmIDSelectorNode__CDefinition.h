// MGetKV3ClassDefaults = {
//	"_class": "CNmIDSelectorNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_conditionNodeIndices":
//	[
//	],
//	"m_values":
//	[
//	],
//	"m_defaultValue": ""
//}
class CNmIDSelectorNode::CDefinition : public CNmIDValueNode::CDefinition
{
	CUtlVectorFixedGrowable< int16, 5 > m_conditionNodeIndices;
	CUtlVectorFixedGrowable< CGlobalSymbol, 5 > m_values;
	CGlobalSymbol m_defaultValue;
};
