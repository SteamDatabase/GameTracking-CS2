// MNetworkIncludeByUserGroup = "Origin"
// MNetworkVarNames = "float32 m_MinFalloff"
// MNetworkVarNames = "float32 m_MaxFalloff"
// MNetworkVarNames = "float32 m_flFadeInDuration"
// MNetworkVarNames = "float32 m_flFadeOutDuration"
// MNetworkVarNames = "float32 m_flMaxWeight"
// MNetworkVarNames = "float32 m_flCurWeight"
// MNetworkVarNames = "char m_netlookupFilename"
// MNetworkVarNames = "bool m_bEnabled"
// MNetworkVarNames = "bool m_bMaster"
// MNetworkVarNames = "bool m_bClientSide"
// MNetworkVarNames = "bool m_bExclusive"
class C_ColorCorrection : public C_BaseEntity
{
	Vector m_vecOrigin;
	// MNetworkEnable
	float32 m_MinFalloff;
	// MNetworkEnable
	float32 m_MaxFalloff;
	// MNetworkEnable
	float32 m_flFadeInDuration;
	// MNetworkEnable
	float32 m_flFadeOutDuration;
	// MNetworkEnable
	float32 m_flMaxWeight;
	// MNetworkEnable
	float32 m_flCurWeight;
	// MNetworkEnable
	char[512] m_netlookupFilename;
	// MNetworkEnable
	bool m_bEnabled;
	// MNetworkEnable
	bool m_bMaster;
	// MNetworkEnable
	bool m_bClientSide;
	// MNetworkEnable
	bool m_bExclusive;
	bool[1] m_bEnabledOnClient;
	float32[1] m_flCurWeightOnClient;
	bool[1] m_bFadingIn;
	float32[1] m_flFadeStartWeight;
	float32[1] m_flFadeStartTime;
	float32[1] m_flFadeDuration;
};
