// MEntityAllowsPortraitWorldSpawn
// MNetworkVarNames = "bool m_bDisabled"
// MNetworkVarNames = "int m_nResolutionX"
// MNetworkVarNames = "int m_nResolutionY"
// MNetworkVarNames = "string_t m_szPanelType"
// MNetworkVarNames = "string_t m_szLayoutFileName"
// MNetworkVarNames = "string_t m_RenderAttrName"
// MNetworkVarNames = "CHandle< CBaseModelEntity > m_TargetEntities"
// MNetworkVarNames = "int m_nTargetChangeCount"
// MNetworkVarNames = "string_t m_vecCSSClasses"
class CInfoOffscreenPanoramaTexture : public CPointEntity
{
	// MNetworkEnable
	bool m_bDisabled;
	// MNetworkEnable
	int32 m_nResolutionX;
	// MNetworkEnable
	int32 m_nResolutionY;
	// MNetworkEnable
	CUtlSymbolLarge m_szPanelType;
	// MNetworkEnable
	CUtlSymbolLarge m_szLayoutFileName;
	// MNetworkEnable
	CUtlSymbolLarge m_RenderAttrName;
	// MNetworkEnable
	CNetworkUtlVectorBase< CHandle< CBaseModelEntity > > m_TargetEntities;
	// MNetworkEnable
	int32 m_nTargetChangeCount;
	// MNetworkEnable
	CNetworkUtlVectorBase< CUtlSymbolLarge > m_vecCSSClasses;
	CUtlSymbolLarge m_szTargetsName;
	CUtlVector< CHandle< CBaseModelEntity > > m_AdditionalTargetEntities;
};
