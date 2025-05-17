// MNetworkIncludeByName = "m_clrRender"
// MNetworkExcludeByName = "CGameSceneNode::m_vecOrigin"
// MNetworkIncludeByUserGroup = "Origin"
// MNetworkIncludeByName = "CGameSceneNode::m_angRotation"
// MNetworkIncludeByName = "CGameSceneNode::m_hParent"
// MNetworkIncludeByName = "m_spawnflags"
// MNetworkVarNames = "Vector m_vDirection"
// MNetworkVarNames = "string_t m_iszEffectName"
// MNetworkVarNames = "string_t m_iszSSEffectName"
// MNetworkVarNames = "Color m_clrOverlay"
// MNetworkVarNames = "bool m_bOn"
// MNetworkVarNames = "bool m_bmaxColor"
// MNetworkVarNames = "float32 m_flSize"
// MNetworkVarNames = "float32 m_flHazeScale"
// MNetworkVarNames = "float32 m_flRotation"
// MNetworkVarNames = "float32 m_flHDRColorScale"
// MNetworkVarNames = "float32 m_flAlphaHaze"
// MNetworkVarNames = "float32 m_flAlphaScale"
// MNetworkVarNames = "float32 m_flAlphaHdr"
// MNetworkVarNames = "float32 m_flFarZScale"
class C_Sun : public C_BaseModelEntity
{
	ParticleIndex_t m_fxSSSunFlareEffectIndex;
	ParticleIndex_t m_fxSunFlareEffectIndex;
	float32 m_fdistNormalize;
	Vector m_vSunPos;
	// MNetworkEnable
	Vector m_vDirection;
	// MNetworkEnable
	CUtlSymbolLarge m_iszEffectName;
	// MNetworkEnable
	CUtlSymbolLarge m_iszSSEffectName;
	// MNetworkEnable
	Color m_clrOverlay;
	// MNetworkEnable
	bool m_bOn;
	// MNetworkEnable
	bool m_bmaxColor;
	// MNetworkEnable
	// MNetworkBitCount = 10
	float32 m_flSize;
	// MNetworkEnable
	// MNetworkBitCount = 10
	float32 m_flHazeScale;
	// MNetworkEnable
	// MNetworkMinValue = -360.000000
	// MNetworkMaxValue = 360.000000
	float32 m_flRotation;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnHDRScaleChanged"
	float32 m_flHDRColorScale;
	// MNetworkEnable
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 2.000000
	float32 m_flAlphaHaze;
	// MNetworkEnable
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 2.000000
	float32 m_flAlphaScale;
	// MNetworkEnable
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 2.000000
	float32 m_flAlphaHdr;
	// MNetworkEnable
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 1.000000
	float32 m_flFarZScale;
};
