class C_OP_PercentageBetweenTransformsVector : public CParticleFunctionOperator
{
	ParticleAttributeIndex_t m_nFieldOutput;
	float32 m_flInputMin;
	float32 m_flInputMax;
	Vector m_vecOutputMin;
	Vector m_vecOutputMax;
	CParticleTransformInput m_TransformStart;
	CParticleTransformInput m_TransformEnd;
	ParticleSetMethod_t m_nSetMethod;
	bool m_bActiveRange;
	bool m_bRadialCheck;
};
