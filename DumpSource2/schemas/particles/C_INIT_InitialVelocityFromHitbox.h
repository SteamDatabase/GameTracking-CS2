class C_INIT_InitialVelocityFromHitbox : public CParticleFunctionInitializer
{
	float32 m_flVelocityMin;
	float32 m_flVelocityMax;
	int32 m_nControlPointNumber;
	char[128] m_HitboxSetName;
	bool m_bUseBones;
};
