class CGlowOverlay
{
	Vector m_vPos;
	bool m_bDirectional;
	Vector m_vDirection;
	bool m_bInSky;
	float32 m_skyObstructionScale;
	CGlowSprite[4] m_Sprites;
	int32 m_nSprites;
	float32 m_flProxyRadius;
	float32 m_flHDRColorScale;
	float32 m_flGlowObstructionScale;
	bool m_bCacheGlowObstruction;
	bool m_bCacheSkyObstruction;
	int16 m_bActivated;
	uint16 m_ListIndex;
	int32 m_queryHandle;
}
