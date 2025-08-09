// MGetKV3ClassDefaults = {
//	"_class": "CNmSyncEventIndexConditionNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nSourceStateNodeIdx": -1,
//	"m_triggerMode": "ExactlyAtEventIndex",
//	"m_syncEventIdx": -1
//}
class CNmSyncEventIndexConditionNode::CDefinition : public CNmBoolValueNode::CDefinition
{
	int16 m_nSourceStateNodeIdx;
	CNmSyncEventIndexConditionNode::TriggerMode_t m_triggerMode;
	int32 m_syncEventIdx;
};
