// MGetKV3ClassDefaults = {
//	"_class": "CNmFloatEaseNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_flEaseTime": 1.000000,
//	"m_flStartValue": 0.000000,
//	"m_nInputValueNodeIdx": -1,
//	"m_easingOp": "Linear",
//	"m_bUseStartValue": false
//}
class CNmFloatEaseNode::CDefinition : public CNmFloatValueNode::CDefinition
{
	float32 m_flEaseTime;
	float32 m_flStartValue;
	int16 m_nInputValueNodeIdx;
	NmEasingOperation_t m_easingOp;
	bool m_bUseStartValue;
};
