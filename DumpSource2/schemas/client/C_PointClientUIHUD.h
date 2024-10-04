class C_PointClientUIHUD : public C_BaseClientUIEntity
{
	bool m_bCheckCSSClasses;
	bool m_bIgnoreInput;
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
};
