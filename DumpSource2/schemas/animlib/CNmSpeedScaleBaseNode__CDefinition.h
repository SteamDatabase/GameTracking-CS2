// MGetKV3ClassDefaults = {
//	"_class": "CNmSpeedScaleBaseNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nChildNodeIdx": -1,
//	"m_nInputValueNodeIdx": -1,
//	"m_flDefaultInputValue": 0.000000
//}
class CNmSpeedScaleBaseNode::CDefinition : public CNmPassthroughNode::CDefinition
{
	int16 m_nInputValueNodeIdx;
	float32 m_flDefaultInputValue;
};
