class C_OP_PercentageBetweenTransforms : public CParticleFunctionOperator
{
	ParticleAttributeIndex_t m_nFieldOutput;
	float32 m_flInputMin;
	float32 m_flInputMax;
	float32 m_flOutputMin;
	float32 m_flOutputMax;
	CParticleTransformInput m_TransformStart;
	CParticleTransformInput m_TransformEnd;
	ParticleSetMethod_t m_nSetMethod;
	bool m_bActiveRange;
	bool m_bRadialCheck;
};
