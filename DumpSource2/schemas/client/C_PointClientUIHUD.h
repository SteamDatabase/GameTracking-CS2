// MNetworkVarNames = "bool m_bIgnoreInput"
// MNetworkVarNames = "float m_flWidth"
// MNetworkVarNames = "float m_flHeight"
// MNetworkVarNames = "float m_flDPI"
// MNetworkVarNames = "float m_flInteractDistance"
// MNetworkVarNames = "float m_flDepthOffset"
// MNetworkVarNames = "uint32 m_unOwnerContext"
// MNetworkVarNames = "uint32 m_unHorizontalAlign"
// MNetworkVarNames = "uint32 m_unVerticalAlign"
// MNetworkVarNames = "uint32 m_unOrientation"
// MNetworkVarNames = "bool m_bAllowInteractionFromAllSceneWorlds"
// MNetworkVarNames = "string_t m_vecCSSClasses"
class C_PointClientUIHUD : public C_BaseClientUIEntity
{
	// MNotSaved
	bool m_bCheckCSSClasses;
	// MNetworkEnable
	bool m_bIgnoreInput;
	// MNetworkEnable
	float32 m_flWidth;
	// MNetworkEnable
	float32 m_flHeight;
	// MNetworkEnable
	float32 m_flDPI;
	// MNetworkEnable
	float32 m_flInteractDistance;
	// MNetworkEnable
	float32 m_flDepthOffset;
	// MNetworkEnable
	uint32 m_unOwnerContext;
	// MNetworkEnable
	uint32 m_unHorizontalAlign;
	// MNetworkEnable
	uint32 m_unVerticalAlign;
	// MNetworkEnable
	uint32 m_unOrientation;
	// MNetworkEnable
	bool m_bAllowInteractionFromAllSceneWorlds;
	// MNetworkEnable
	C_NetworkUtlVectorBase< CUtlSymbolLarge > m_vecCSSClasses;
};
