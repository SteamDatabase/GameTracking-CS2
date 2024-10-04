class CInfoOffscreenPanoramaTexture : public CPointEntity
{
	bool m_bDisabled;
	int32 m_nResolutionX;
	int32 m_nResolutionY;
	CUtlSymbolLarge m_szLayoutFileName;
	CUtlSymbolLarge m_RenderAttrName;
	CNetworkUtlVectorBase< CHandle< CBaseModelEntity > > m_TargetEntities;
	int32 m_nTargetChangeCount;
	CNetworkUtlVectorBase< CUtlSymbolLarge > m_vecCSSClasses;
	CUtlSymbolLarge m_szTargetsName;
	CUtlVector< CHandle< CBaseModelEntity > > m_AdditionalTargetEntities;
}
