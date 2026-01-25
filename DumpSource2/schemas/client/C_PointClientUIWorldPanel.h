// MEntityAllowsPortraitWorldSpawn
// MNetworkVarNames = "bool m_bIgnoreInput"
// MNetworkVarNames = "bool m_bLit"
// MNetworkVarNames = "bool m_bFollowPlayerAcrossTeleport"
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
// MNetworkVarNames = "bool m_bOpaque"
// MNetworkVarNames = "bool m_bNoDepth"
// MNetworkVarNames = "bool m_bVisibleWhenParentNoDraw"
// MNetworkVarNames = "bool m_bRenderBackface"
// MNetworkVarNames = "bool m_bUseOffScreenIndicator"
// MNetworkVarNames = "bool m_bExcludeFromSaveGames"
// MNetworkVarNames = "bool m_bGrabbable"
// MNetworkVarNames = "bool m_bOnlyRenderToTexture"
// MNetworkVarNames = "bool m_bDisableMipGen"
// MNetworkVarNames = "int32 m_nExplicitImageLayout"
class C_PointClientUIWorldPanel : public C_BaseClientUIEntity
{
	// MNotSaved
	bool m_bForceRecreateNextUpdate;
	// MNotSaved
	bool m_bMoveViewToPlayerNextThink;
	// MNotSaved
	bool m_bCheckCSSClasses;
	// MNotSaved
	CTransform m_anchorDeltaTransform;
	// MNotSaved
	CPointOffScreenIndicatorUi* m_pOffScreenIndicator;
	// MNetworkEnable
	bool m_bIgnoreInput;
	// MNetworkEnable
	bool m_bLit;
	// MNetworkEnable
	bool m_bFollowPlayerAcrossTeleport;
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
	// MNetworkEnable
	bool m_bOpaque;
	// MNetworkEnable
	bool m_bNoDepth;
	// MNetworkEnable
	bool m_bVisibleWhenParentNoDraw;
	// MNetworkEnable
	bool m_bRenderBackface;
	// MNetworkEnable
	bool m_bUseOffScreenIndicator;
	// MNetworkEnable
	bool m_bExcludeFromSaveGames;
	// MNetworkEnable
	bool m_bGrabbable;
	// MNetworkEnable
	bool m_bOnlyRenderToTexture;
	// MNetworkEnable
	bool m_bDisableMipGen;
	// MNetworkEnable
	int32 m_nExplicitImageLayout;
};
