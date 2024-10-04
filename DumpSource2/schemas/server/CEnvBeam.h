class CEnvBeam : public CBeam
{
	int32 m_active;
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_spriteTexture;
	CUtlSymbolLarge m_iszStartEntity;
	CUtlSymbolLarge m_iszEndEntity;
	float32 m_life;
	float32 m_boltWidth;
	float32 m_noiseAmplitude;
	int32 m_speed;
	float32 m_restrike;
	CUtlSymbolLarge m_iszSpriteName;
	int32 m_frameStart;
	Vector m_vEndPointWorld;
	Vector m_vEndPointRelative;
	float32 m_radius;
	Touch_t m_TouchType;
	CUtlSymbolLarge m_iFilterName;
	CHandle< CBaseEntity > m_hFilter;
	CUtlSymbolLarge m_iszDecal;
	CEntityIOOutput m_OnTouchedByEntity;
};
