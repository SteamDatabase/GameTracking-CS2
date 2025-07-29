class CPhysMotor : public CLogicalEntity
{
	CUtlSymbolLarge m_nameAttach;
	CUtlSymbolLarge m_nameAnchor;
	CHandle< CBaseEntity > m_hAttachedObject;
	CHandle< CBaseEntity > m_hAnchorObject;
	float32 m_spinUp;
	float32 m_spinDown;
	float32 m_flMotorFriction;
	float32 m_additionalAcceleration;
	float32 m_angularAcceleration;
	float32 m_flTorqueScale;
	float32 m_flTargetSpeed;
	float32 m_flSpeedWhenSpinUpOrSpinDownStarted;
	CMotorController m_motor;
};
