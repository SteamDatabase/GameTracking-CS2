class C_OP_RenderLights : public C_OP_RenderPoints
{
	float32 m_flAnimationRate;
	AnimationType_t m_nAnimationType;
	bool m_bAnimateInFPS;
	float32 m_flMinSize;
	float32 m_flMaxSize;
	float32 m_flStartFadeSize;
	float32 m_flEndFadeSize;
};
