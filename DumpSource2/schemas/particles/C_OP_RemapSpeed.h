class C_OP_RemapSpeed : public CParticleFunctionOperator
{
	ParticleAttributeIndex_t m_nFieldOutput;
	float32 m_flInputMin;
	float32 m_flInputMax;
	float32 m_flOutputMin;
	float32 m_flOutputMax;
	ParticleSetMethod_t m_nSetMethod;
	bool m_bIgnoreDelta;
};
