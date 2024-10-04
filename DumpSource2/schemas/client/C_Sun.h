class C_Sun : public C_BaseModelEntity
{
	ParticleIndex_t m_fxSSSunFlareEffectIndex;
	ParticleIndex_t m_fxSunFlareEffectIndex;
	float32 m_fdistNormalize;
	Vector m_vSunPos;
	Vector m_vDirection;
	CUtlSymbolLarge m_iszEffectName;
	CUtlSymbolLarge m_iszSSEffectName;
	Color m_clrOverlay;
	bool m_bOn;
	bool m_bmaxColor;
	float32 m_flSize;
	float32 m_flHazeScale;
	float32 m_flRotation;
	float32 m_flHDRColorScale;
	float32 m_flAlphaHaze;
	float32 m_flAlphaScale;
	float32 m_flAlphaHdr;
	float32 m_flFarZScale;
};
