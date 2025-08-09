// MGetKV3ClassDefaults = {
//	"_class": "CNmFloatComparisonNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nInputValueNodeIdx": -1,
//	"m_nComparandValueNodeIdx": -1,
//	"m_comparison": "GreaterThanEqual",
//	"m_flEpsilon": 0.000000,
//	"m_flComparisonValue": 0.000000
//}
class CNmFloatComparisonNode::CDefinition : public CNmBoolValueNode::CDefinition
{
	int16 m_nInputValueNodeIdx;
	int16 m_nComparandValueNodeIdx;
	CNmFloatComparisonNode::Comparison_t m_comparison;
	float32 m_flEpsilon;
	float32 m_flComparisonValue;
};
