class C_OP_FadeOut : public CParticleFunctionOperator
{
	float32 m_flFadeOutTimeMin;
	float32 m_flFadeOutTimeMax;
	float32 m_flFadeOutTimeExp;
	float32 m_flFadeBias;
	bool m_bProportional;
	bool m_bEaseInAndOut;
};
