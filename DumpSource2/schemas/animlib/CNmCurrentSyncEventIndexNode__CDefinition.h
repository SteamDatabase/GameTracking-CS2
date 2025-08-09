// MGetKV3ClassDefaults = {
//	"_class": "CNmCurrentSyncEventIndexNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nSourceStateNodeIdx": -1,
//	"m_bOnlyReturnPercentageThrough": false
//}
class CNmCurrentSyncEventIndexNode::CDefinition : public CNmFloatValueNode::CDefinition
{
	int16 m_nSourceStateNodeIdx;
	bool m_bOnlyReturnPercentageThrough;
};
