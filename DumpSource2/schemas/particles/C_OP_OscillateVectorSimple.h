class C_OP_OscillateVectorSimple : public CParticleFunctionOperator
{
	Vector m_Rate;
	Vector m_Frequency;
	ParticleAttributeIndex_t m_nField;
	float32 m_flOscMult;
	float32 m_flOscAdd;
	bool m_bOffset;
};
