class C_OP_OscillateScalarSimple : public CParticleFunctionOperator
{
	float32 m_Rate;
	float32 m_Frequency;
	ParticleAttributeIndex_t m_nField;
	float32 m_flOscMult;
	float32 m_flOscAdd;
};
