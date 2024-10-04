class C_OP_RemapParticleCountOnScalarEndCap : public CParticleFunctionOperator
{
	ParticleAttributeIndex_t m_nFieldOutput;
	int32 m_nInputMin;
	int32 m_nInputMax;
	float32 m_flOutputMin;
	float32 m_flOutputMax;
	bool m_bBackwards;
	ParticleSetMethod_t m_nSetMethod;
};
