class C_OP_RotateVector : public CParticleFunctionOperator
{
	ParticleAttributeIndex_t m_nFieldOutput;
	Vector m_vecRotAxisMin;
	Vector m_vecRotAxisMax;
	float32 m_flRotRateMin;
	float32 m_flRotRateMax;
	bool m_bNormalize;
	CPerParticleFloatInput m_flScale;
};
