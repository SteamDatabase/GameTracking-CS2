// MNetworkIncludeByUserGroup = "Origin"
// MNetworkIncludeByName = "CGameSceneNode::m_angRotation"
// MNetworkIncludeByName = "m_clrRender"
// MNetworkIncludeByName = "CGameSceneNode::m_hParent"
// MNetworkIncludeByName = "m_spawnflags"
// MNetworkVarNames = "uint32 m_nHorizontalSize"
// MNetworkVarNames = "uint32 m_nVerticalSize"
// MNetworkVarNames = "uint32 m_nMinDist"
// MNetworkVarNames = "uint32 m_nMaxDist"
// MNetworkVarNames = "uint32 m_nOuterMaxDist"
// MNetworkVarNames = "float32 m_flGlowProxySize"
// MNetworkVarNames = "float32 m_flHDRColorScale"
class C_LightGlow : public C_BaseModelEntity
{
	// MNetworkEnable
	uint32 m_nHorizontalSize;
	// MNetworkEnable
	uint32 m_nVerticalSize;
	// MNetworkEnable
	uint32 m_nMinDist;
	// MNetworkEnable
	uint32 m_nMaxDist;
	// MNetworkEnable
	uint32 m_nOuterMaxDist;
	// MNetworkEnable
	// MNetworkBitCount = 6
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 64.000000
	// MNetworkEncodeFlags = 2
	float32 m_flGlowProxySize;
	// MNetworkEnable
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 100.000000
	// MNetworkChangeCallback = "OnHDRColorScaleChanged"
	float32 m_flHDRColorScale;
	C_LightGlowOverlay m_GlowOverlay;
};
