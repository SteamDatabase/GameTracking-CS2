// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CNmSyncEventIndexConditionNode::CDefinition : public CNmBoolValueNode::CDefinition
{
	int16 m_nSourceStateNodeIdx;
	CNmSyncEventIndexConditionNode::TriggerMode_t m_triggerMode;
	int32 m_syncEventIdx;
};
