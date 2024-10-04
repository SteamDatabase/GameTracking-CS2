class C_OP_RemapTransformVisibilityToScalar : public CParticleFunctionOperator
{
	ParticleSetMethod_t m_nSetMethod;
	CParticleTransformInput m_TransformInput;
	ParticleAttributeIndex_t m_nFieldOutput;
	float32 m_flInputMin;
	float32 m_flInputMax;
	float32 m_flOutputMin;
	float32 m_flOutputMax;
	float32 m_flRadius;
};
