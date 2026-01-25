class CPhysHinge : public CPhysConstraint
{
	// MNotSaved
	ConstraintSoundInfo m_soundInfo;
	CEntityIOOutput m_NotifyMinLimitReached;
	CEntityIOOutput m_NotifyMaxLimitReached;
	bool m_bAtMinLimit;
	bool m_bAtMaxLimit;
	// MNotSaved
	constraint_hingeparams_t m_hinge;
	float32 m_hingeFriction;
	float32 m_systemLoadScale;
	// MNotSaved
	bool m_bIsAxisLocal;
	float32 m_flMinRotation;
	float32 m_flMaxRotation;
	float32 m_flInitialRotation;
	float32 m_flMotorFrequency;
	float32 m_flMotorDampingRatio;
	float32 m_flAngleSpeed;
	float32 m_flAngleSpeedThreshold;
	float32 m_flLimitsDebugVisRotation;
	CEntityIOOutput m_OnStartMoving;
	CEntityIOOutput m_OnStopMoving;
};
