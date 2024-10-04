class CNmTargetInfoNode::CDefinition : public CNmFloatValueNode::CDefinition
{
	int16 m_nInputValueNodeIdx;
	CNmTargetInfoNode::Info_t m_infoType;
	bool m_bIsWorldSpaceTarget;
};
