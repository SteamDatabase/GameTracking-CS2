class CNmRootMotionOverrideNode::CDefinition : public CNmPassthroughNode::CDefinition
{
	int16 m_desiredMovingVelocityNodeIdx;
	int16 m_desiredFacingDirectionNodeIdx;
	int16 m_linearVelocityLimitNodeIdx;
	int16 m_angularVelocityLimitNodeIdx;
	float32 m_maxLinearVelocity;
	float32 m_maxAngularVelocityRadians;
	CNmBitFlags m_overrideFlags;
}
