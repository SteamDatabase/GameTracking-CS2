// MGetKV3ClassDefaults = {
//	"_class": "CNmIDToFloatNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nInputValueNodeIdx": -1,
//	"m_defaultValue": 0.000000,
//	"m_IDs":
//	[
//	],
//	"m_values":
//	[
//	]
//}
class CNmIDToFloatNode::CDefinition : public CNmFloatValueNode::CDefinition
{
	int16 m_nInputValueNodeIdx;
	float32 m_defaultValue;
	CUtlLeanVectorFixedGrowable< CGlobalSymbol, 5 > m_IDs;
	CUtlLeanVectorFixedGrowable< float32, 5 > m_values;
};
