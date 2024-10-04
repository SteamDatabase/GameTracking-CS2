class CSun : public CBaseModelEntity
{
	Vector m_vDirection;
	Color m_clrOverlay;
	CUtlSymbolLarge m_iszEffectName;
	CUtlSymbolLarge m_iszSSEffectName;
	bool m_bOn;
	bool m_bmaxColor;
	float32 m_flSize;
	float32 m_flRotation;
	float32 m_flHazeScale;
	float32 m_flAlphaHaze;
	float32 m_flAlphaHdr;
	float32 m_flAlphaScale;
	float32 m_flHDRColorScale;
	float32 m_flFarZScale;
};
