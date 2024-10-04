class C_OP_RampScalarSpline : public CParticleFunctionOperator
{
	float32 m_RateMin;
	float32 m_RateMax;
	float32 m_flStartTime_min;
	float32 m_flStartTime_max;
	float32 m_flEndTime_min;
	float32 m_flEndTime_max;
	float32 m_flBias;
	ParticleAttributeIndex_t m_nField;
	bool m_bProportionalOp;
	bool m_bEaseOut;
};
