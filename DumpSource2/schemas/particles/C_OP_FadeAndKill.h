class C_OP_FadeAndKill : public CParticleFunctionOperator
{
	float32 m_flStartFadeInTime;
	float32 m_flEndFadeInTime;
	float32 m_flStartFadeOutTime;
	float32 m_flEndFadeOutTime;
	float32 m_flStartAlpha;
	float32 m_flEndAlpha;
	bool m_bForcePreserveParticleOrder;
};
