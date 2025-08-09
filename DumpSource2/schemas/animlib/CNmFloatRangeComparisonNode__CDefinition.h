// MGetKV3ClassDefaults = {
//	"_class": "CNmFloatRangeComparisonNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_range":
//	{
//		"m_flMin": 340282346638528859811704183484516925440.000000,
//		"m_flMax": -340282346638528859811704183484516925440.000000
//	},
//	"m_nInputValueNodeIdx": -1,
//	"m_bIsInclusiveCheck": true
//}
class CNmFloatRangeComparisonNode::CDefinition : public CNmBoolValueNode::CDefinition
{
	Range_t m_range;
	int16 m_nInputValueNodeIdx;
	bool m_bIsInclusiveCheck;
};
