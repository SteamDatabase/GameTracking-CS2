class C_OP_PercentageBetweenTransformLerpCPs : public CParticleFunctionOperator
{
	ParticleAttributeIndex_t m_nFieldOutput;
	float32 m_flInputMin;
	float32 m_flInputMax;
	CParticleTransformInput m_TransformStart;
	CParticleTransformInput m_TransformEnd;
	int32 m_nOutputStartCP;
	int32 m_nOutputStartField;
	int32 m_nOutputEndCP;
	int32 m_nOutputEndField;
	ParticleSetMethod_t m_nSetMethod;
	bool m_bActiveRange;
	bool m_bRadialCheck;
};
