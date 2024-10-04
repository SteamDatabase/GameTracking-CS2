class C_OP_RampScalarSplineSimple : public CParticleFunctionOperator
{
	float32 m_Rate;
	float32 m_flStartTime;
	float32 m_flEndTime;
	ParticleAttributeIndex_t m_nField;
	bool m_bEaseOut;
};
