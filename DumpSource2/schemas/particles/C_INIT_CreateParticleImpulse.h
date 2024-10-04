class C_INIT_CreateParticleImpulse : public CParticleFunctionInitializer
{
	CPerParticleFloatInput m_InputRadius;
	CPerParticleFloatInput m_InputMagnitude;
	ParticleFalloffFunction_t m_nFalloffFunction;
	CPerParticleFloatInput m_InputFalloffExp;
	ParticleImpulseType_t m_nImpulseType;
};
