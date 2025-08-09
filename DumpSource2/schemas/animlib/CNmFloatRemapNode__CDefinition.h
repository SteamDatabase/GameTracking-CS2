// MGetKV3ClassDefaults = {
//	"_class": "CNmFloatRemapNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nInputValueNodeIdx": -1,
//	"m_inputRange":
//	{
//		"m_flBegin": 0.000000,
//		"m_flEnd": 0.000000
//	},
//	"m_outputRange":
//	{
//		"m_flBegin": 0.000000,
//		"m_flEnd": 0.000000
//	}
//}
class CNmFloatRemapNode::CDefinition : public CNmFloatValueNode::CDefinition
{
	int16 m_nInputValueNodeIdx;
	CNmFloatRemapNode::RemapRange_t m_inputRange;
	CNmFloatRemapNode::RemapRange_t m_outputRange;
};
