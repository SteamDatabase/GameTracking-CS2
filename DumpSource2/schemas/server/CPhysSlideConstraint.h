class CPhysSlideConstraint : public CPhysConstraint
{
	Vector m_axisEnd;
	float32 m_slideFriction;
	float32 m_systemLoadScale;
	float32 m_initialOffset;
	bool m_bEnableLinearConstraint;
	bool m_bEnableAngularConstraint;
	float32 m_flMotorFrequency;
	float32 m_flMotorDampingRatio;
	bool m_bUseEntityPivot;
	ConstraintSoundInfo m_soundInfo;
};
