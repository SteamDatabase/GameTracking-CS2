class C_OP_OscillateVector : public CParticleFunctionOperator
{
	Vector m_RateMin;
	Vector m_RateMax;
	Vector m_FrequencyMin;
	Vector m_FrequencyMax;
	ParticleAttributeIndex_t m_nField;
	bool m_bProportional;
	bool m_bProportionalOp;
	bool m_bOffset;
	float32 m_flStartTime_min;
	float32 m_flStartTime_max;
	float32 m_flEndTime_min;
	float32 m_flEndTime_max;
	CPerParticleFloatInput m_flOscMult;
	CPerParticleFloatInput m_flOscAdd;
	CPerParticleFloatInput m_flRateScale;
};
