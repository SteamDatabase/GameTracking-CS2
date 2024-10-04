class C_OP_ColorInterpolateRandom : public CParticleFunctionOperator
{
	Color m_ColorFadeMin;
	Color m_ColorFadeMax;
	float32 m_flFadeStartTime;
	float32 m_flFadeEndTime;
	ParticleAttributeIndex_t m_nFieldOutput;
	bool m_bEaseInOut;
};
