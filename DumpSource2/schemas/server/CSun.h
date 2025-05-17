// MNetworkIncludeByName = "m_clrRender"
// MNetworkVarNames = "Vector m_vDirection"
// MNetworkVarNames = "Color m_clrOverlay"
// MNetworkVarNames = "string_t m_iszEffectName"
// MNetworkVarNames = "string_t m_iszSSEffectName"
// MNetworkVarNames = "bool m_bOn"
// MNetworkVarNames = "bool m_bmaxColor"
// MNetworkVarNames = "float32 m_flSize"
// MNetworkVarNames = "float32 m_flRotation"
// MNetworkVarNames = "float32 m_flHazeScale"
// MNetworkVarNames = "float32 m_flAlphaHaze"
// MNetworkVarNames = "float32 m_flAlphaHdr"
// MNetworkVarNames = "float32 m_flAlphaScale"
// MNetworkVarNames = "float32 m_flHDRColorScale"
// MNetworkVarNames = "float32 m_flFarZScale"
class CSun : public CBaseModelEntity
{
	// MNetworkEnable
	Vector m_vDirection;
	// MNetworkEnable
	Color m_clrOverlay;
	// MNetworkEnable
	CUtlSymbolLarge m_iszEffectName;
	// MNetworkEnable
	CUtlSymbolLarge m_iszSSEffectName;
	// MNetworkEnable
	bool m_bOn;
	// MNetworkEnable
	bool m_bmaxColor;
	// MNetworkEnable
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 100.000000
	float32 m_flSize;
	// MNetworkEnable
	// MNetworkMinValue = -360.000000
	// MNetworkMaxValue = 360.000000
	float32 m_flRotation;
	// MNetworkEnable
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 100.000000
	float32 m_flHazeScale;
	// MNetworkEnable
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 2.000000
	float32 m_flAlphaHaze;
	// MNetworkEnable
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 2.000000
	float32 m_flAlphaHdr;
	// MNetworkEnable
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 2.000000
	float32 m_flAlphaScale;
	// MNetworkEnable
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 100.000000
	float32 m_flHDRColorScale;
	// MNetworkEnable
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 1.000000
	float32 m_flFarZScale;
};
