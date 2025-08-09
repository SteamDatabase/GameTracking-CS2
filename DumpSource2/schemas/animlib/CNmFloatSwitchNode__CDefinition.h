// MGetKV3ClassDefaults = {
//	"_class": "CNmFloatSwitchNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nSwitchValueNodeIdx": -1,
//	"m_nTrueValueNodeIdx": -1,
//	"m_nFalseValueNodeIdx": -1,
//	"m_flFalseValue": 0.000000,
//	"m_flTrueValue": 1.000000
//}
class CNmFloatSwitchNode::CDefinition : public CNmFloatValueNode::CDefinition
{
	int16 m_nSwitchValueNodeIdx;
	int16 m_nTrueValueNodeIdx;
	int16 m_nFalseValueNodeIdx;
	float32 m_flFalseValue;
	float32 m_flTrueValue;
};
