class C_OP_ColorInterpolate : public CParticleFunctionOperator
{
	Color m_ColorFade;
	float32 m_flFadeStartTime;
	float32 m_flFadeEndTime;
	ParticleAttributeIndex_t m_nFieldOutput;
	bool m_bEaseInOut;
};
