class C_PointClientUIWorldPanel : public C_BaseClientUIEntity
{
	bool m_bForceRecreateNextUpdate;
	bool m_bMoveViewToPlayerNextThink;
	bool m_bCheckCSSClasses;
	CTransform m_anchorDeltaTransform;
	CPointOffScreenIndicatorUi* m_pOffScreenIndicator;
	bool m_bIgnoreInput;
	bool m_bLit;
	bool m_bFollowPlayerAcrossTeleport;
	float32 m_flWidth;
	float32 m_flHeight;
	float32 m_flDPI;
	float32 m_flInteractDistance;
	float32 m_flDepthOffset;
	uint32 m_unOwnerContext;
	uint32 m_unHorizontalAlign;
	uint32 m_unVerticalAlign;
	uint32 m_unOrientation;
	bool m_bAllowInteractionFromAllSceneWorlds;
	C_NetworkUtlVectorBase< CUtlSymbolLarge > m_vecCSSClasses;
	bool m_bOpaque;
	bool m_bNoDepth;
	bool m_bRenderBackface;
	bool m_bUseOffScreenIndicator;
	bool m_bExcludeFromSaveGames;
	bool m_bGrabbable;
	bool m_bOnlyRenderToTexture;
	bool m_bDisableMipGen;
	int32 m_nExplicitImageLayout;
}
