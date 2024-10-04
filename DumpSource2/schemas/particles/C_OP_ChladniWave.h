class C_OP_ChladniWave : public CParticleFunctionOperator
{
	ParticleAttributeIndex_t m_nFieldOutput;
	CPerParticleFloatInput m_flInputMin;
	CPerParticleFloatInput m_flInputMax;
	CPerParticleFloatInput m_flOutputMin;
	CPerParticleFloatInput m_flOutputMax;
	CPerParticleVecInput m_vecWaveLength;
	CPerParticleVecInput m_vecHarmonics;
	ParticleSetMethod_t m_nSetMethod;
	int32 m_nLocalSpaceControlPoint;
	bool m_b3D;
};
