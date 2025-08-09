// MGetKV3ClassDefaults = {
//	"_class": "CNmFloatClampNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nInputValueNodeIdx": -1,
//	"m_clampRange":
//	{
//		"m_flMin": 0.000000,
//		"m_flMax": 0.000000
//	}
//}
class CNmFloatClampNode::CDefinition : public CNmFloatValueNode::CDefinition
{
	int16 m_nInputValueNodeIdx;
	Range_t m_clampRange;
};
