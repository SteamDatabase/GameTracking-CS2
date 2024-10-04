class CPhysMotor : public CLogicalEntity
{
	CUtlSymbolLarge m_nameAttach;
	CHandle< CBaseEntity > m_hAttachedObject;
	float32 m_spinUp;
	float32 m_additionalAcceleration;
	float32 m_angularAcceleration;
	GameTime_t m_lastTime;
	CMotorController m_motor;
}
