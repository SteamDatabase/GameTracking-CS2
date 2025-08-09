// MGetKV3ClassDefaults = {
//	"_class": "CNmFloatSelectorNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_conditionNodeIndices":
//	[
//	],
//	"m_values":
//	[
//	],
//	"m_flDefaultValue": 0.000000,
//	"m_flEaseTime": 0.200000,
//	"m_easingOp": "Linear"
//}
class CNmFloatSelectorNode::CDefinition : public CNmFloatValueNode::CDefinition
{
	CUtlVectorFixedGrowable< int16, 5 > m_conditionNodeIndices;
	CUtlVectorFixedGrowable< float32, 5 > m_values;
	float32 m_flDefaultValue;
	float32 m_flEaseTime;
	NmEasingOperation_t m_easingOp;
};
