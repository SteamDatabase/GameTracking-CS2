// MNetworkIncludeByUserGroup = "Origin"
// MNetworkVarNames = "float32 m_flFadeInDuration"
// MNetworkVarNames = "float32 m_flFadeOutDuration"
// MNetworkVarNames = "float32 m_flMaxWeight"
// MNetworkVarNames = "bool m_bEnabled"
// MNetworkVarNames = "bool m_bMaster"
// MNetworkVarNames = "bool m_bClientSide"
// MNetworkVarNames = "bool m_bExclusive"
// MNetworkVarNames = "float32 m_MinFalloff"
// MNetworkVarNames = "float32 m_MaxFalloff"
// MNetworkVarNames = "float32 m_flCurWeight"
// MNetworkVarNames = "char m_netlookupFilename"
class CColorCorrection : public CBaseEntity
{
	// MNetworkEnable
	float32 m_flFadeInDuration;
	// MNetworkEnable
	float32 m_flFadeOutDuration;
	float32 m_flStartFadeInWeight;
	float32 m_flStartFadeOutWeight;
	GameTime_t m_flTimeStartFadeIn;
	GameTime_t m_flTimeStartFadeOut;
	// MNetworkEnable
	float32 m_flMaxWeight;
	bool m_bStartDisabled;
	// MNetworkEnable
	bool m_bEnabled;
	// MNetworkEnable
	bool m_bMaster;
	// MNetworkEnable
	bool m_bClientSide;
	// MNetworkEnable
	bool m_bExclusive;
	// MNetworkEnable
	float32 m_MinFalloff;
	// MNetworkEnable
	float32 m_MaxFalloff;
	// MNetworkEnable
	float32 m_flCurWeight;
	// MNetworkEnable
	char[512] m_netlookupFilename;
	CUtlSymbolLarge m_lookupFilename;
};
