class C_OP_RemapTransformVisibilityToVector : public CParticleFunctionOperator
{
	ParticleSetMethod_t m_nSetMethod;
	CParticleTransformInput m_TransformInput;
	ParticleAttributeIndex_t m_nFieldOutput;
	float32 m_flInputMin;
	float32 m_flInputMax;
	Vector m_vecOutputMin;
	Vector m_vecOutputMax;
	float32 m_flRadius;
};
