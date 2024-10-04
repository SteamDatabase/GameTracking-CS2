class C_INIT_PositionPlaceOnGround : public CParticleFunctionInitializer
{
	CPerParticleFloatInput m_flOffset;
	CPerParticleFloatInput m_flMaxTraceLength;
	char[128] m_CollisionGroupName;
	ParticleTraceSet_t m_nTraceSet;
	ParticleTraceMissBehavior_t m_nTraceMissBehavior;
	bool m_bIncludeWater;
	bool m_bSetNormal;
	bool m_bSetPXYZOnly;
	bool m_bTraceAlongNormal;
	bool m_bOffsetonColOnly;
	float32 m_flOffsetByRadiusFactor;
	int32 m_nPreserveOffsetCP;
	int32 m_nIgnoreCP;
};
