class C_OP_DistanceBetweenVecs : public CParticleFunctionOperator
{
	ParticleAttributeIndex_t m_nFieldOutput;
	CPerParticleVecInput m_vecPoint1;
	CPerParticleVecInput m_vecPoint2;
	CPerParticleFloatInput m_flInputMin;
	CPerParticleFloatInput m_flInputMax;
	CPerParticleFloatInput m_flOutputMin;
	CPerParticleFloatInput m_flOutputMax;
	ParticleSetMethod_t m_nSetMethod;
	bool m_bDeltaTime;
};
