class C_LightGlow : public C_BaseModelEntity
{
	uint32 m_nHorizontalSize;
	uint32 m_nVerticalSize;
	uint32 m_nMinDist;
	uint32 m_nMaxDist;
	uint32 m_nOuterMaxDist;
	float32 m_flGlowProxySize;
	float32 m_flHDRColorScale;
	C_LightGlowOverlay m_GlowOverlay;
};
