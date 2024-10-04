class C_TriggerPhysics : public C_BaseTrigger
{
	float32 m_gravityScale;
	float32 m_linearLimit;
	float32 m_linearDamping;
	float32 m_angularLimit;
	float32 m_angularDamping;
	float32 m_linearForce;
	float32 m_flFrequency;
	float32 m_flDampingRatio;
	Vector m_vecLinearForcePointAt;
	bool m_bCollapseToForcePoint;
	Vector m_vecLinearForcePointAtWorld;
	Vector m_vecLinearForceDirection;
	bool m_bConvertToDebrisWhenPossible;
}
