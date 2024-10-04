class C_OP_CalculateVectorAttribute : public CParticleFunctionOperator
{
	Vector m_vStartValue;
	ParticleAttributeIndex_t m_nFieldInput1;
	float32 m_flInputScale1;
	ParticleAttributeIndex_t m_nFieldInput2;
	float32 m_flInputScale2;
	ControlPointReference_t m_nControlPointInput1;
	float32 m_flControlPointScale1;
	ControlPointReference_t m_nControlPointInput2;
	float32 m_flControlPointScale2;
	ParticleAttributeIndex_t m_nFieldOutput;
	Vector m_vFinalOutputScale;
};
