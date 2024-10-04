class CClientAlphaProperty : public IClientAlphaProperty
{
	uint8 m_nRenderFX;
	uint8 m_nRenderMode;
	bitfield:1 m_bAlphaOverride;
	bitfield:1 m_bShadowAlphaOverride;
	bitfield:6 m_nReserved;
	uint8 m_nAlpha;
	uint16 m_nDesyncOffset;
	uint16 m_nReserved2;
	uint16 m_nDistFadeStart;
	uint16 m_nDistFadeEnd;
	float32 m_flFadeScale;
	GameTime_t m_flRenderFxStartTime;
	float32 m_flRenderFxDuration;
}
