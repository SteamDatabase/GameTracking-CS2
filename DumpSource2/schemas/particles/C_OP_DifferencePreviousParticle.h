class C_OP_DifferencePreviousParticle : public CParticleFunctionOperator
{
	ParticleAttributeIndex_t m_nFieldInput;
	ParticleAttributeIndex_t m_nFieldOutput;
	float32 m_flInputMin;
	float32 m_flInputMax;
	float32 m_flOutputMin;
	float32 m_flOutputMax;
	ParticleSetMethod_t m_nSetMethod;
	bool m_bActiveRange;
	bool m_bSetPreviousParticle;
};
