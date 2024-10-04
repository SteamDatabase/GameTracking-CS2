class C_OP_OscillateScalar : public CParticleFunctionOperator
{
	float32 m_RateMin;
	float32 m_RateMax;
	float32 m_FrequencyMin;
	float32 m_FrequencyMax;
	ParticleAttributeIndex_t m_nField;
	bool m_bProportional;
	bool m_bProportionalOp;
	float32 m_flStartTime_min;
	float32 m_flStartTime_max;
	float32 m_flEndTime_min;
	float32 m_flEndTime_max;
	float32 m_flOscMult;
	float32 m_flOscAdd;
};
