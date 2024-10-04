class C_OP_RampScalarLinear : public CParticleFunctionOperator
{
	float32 m_RateMin;
	float32 m_RateMax;
	float32 m_flStartTime_min;
	float32 m_flStartTime_max;
	float32 m_flEndTime_min;
	float32 m_flEndTime_max;
	ParticleAttributeIndex_t m_nField;
	bool m_bProportionalOp;
};
