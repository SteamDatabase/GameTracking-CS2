class CPhysBallSocket : public CPhysConstraint
{
	float32 m_flJointFriction;
	bool m_bEnableSwingLimit;
	float32 m_flSwingLimit;
	bool m_bEnableTwistLimit;
	float32 m_flMinTwistAngle;
	float32 m_flMaxTwistAngle;
};
