// MGetKV3ClassDefaults = {
//	"_class": "CNmScaleNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nChildNodeIdx": -1,
//	"m_nMaskNodeIdx": -1,
//	"m_nEnableNodeIdx": -1
//}
class CNmScaleNode::CDefinition : public CNmPassthroughNode::CDefinition
{
	int16 m_nMaskNodeIdx;
	int16 m_nEnableNodeIdx;
};
