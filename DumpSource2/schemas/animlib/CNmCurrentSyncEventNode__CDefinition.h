// MGetKV3ClassDefaults = {
//	"_class": "CNmCurrentSyncEventNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nSourceStateNodeIdx": -1,
//	"m_infoType": "IndexAndPercentage"
//}
class CNmCurrentSyncEventNode::CDefinition : public CNmFloatValueNode::CDefinition
{
	int16 m_nSourceStateNodeIdx;
	CNmCurrentSyncEventNode::InfoType_t m_infoType;
};
