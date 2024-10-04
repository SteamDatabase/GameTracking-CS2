class C_OP_RemapParticleCountToScalar : public CParticleFunctionOperator
{
	ParticleAttributeIndex_t m_nFieldOutput;
	CParticleCollectionFloatInput m_nInputMin;
	CParticleCollectionFloatInput m_nInputMax;
	CParticleCollectionFloatInput m_flOutputMin;
	CParticleCollectionFloatInput m_flOutputMax;
	bool m_bActiveRange;
	ParticleSetMethod_t m_nSetMethod;
};
