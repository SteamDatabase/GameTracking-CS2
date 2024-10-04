class C_OP_RenderScreenShake : public CParticleFunctionRenderer
{
	float32 m_flDurationScale;
	float32 m_flRadiusScale;
	float32 m_flFrequencyScale;
	float32 m_flAmplitudeScale;
	ParticleAttributeIndex_t m_nRadiusField;
	ParticleAttributeIndex_t m_nDurationField;
	ParticleAttributeIndex_t m_nFrequencyField;
	ParticleAttributeIndex_t m_nAmplitudeField;
	int32 m_nFilterCP;
};
