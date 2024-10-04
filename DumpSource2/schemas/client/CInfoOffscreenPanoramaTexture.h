class CInfoOffscreenPanoramaTexture : public C_PointEntity
{
	bool m_bDisabled;
	int32 m_nResolutionX;
	int32 m_nResolutionY;
	CUtlSymbolLarge m_szLayoutFileName;
	CUtlSymbolLarge m_RenderAttrName;
	C_NetworkUtlVectorBase< CHandle< C_BaseModelEntity > > m_TargetEntities;
	int32 m_nTargetChangeCount;
	C_NetworkUtlVectorBase< CUtlSymbolLarge > m_vecCSSClasses;
	bool m_bCheckCSSClasses;
};
