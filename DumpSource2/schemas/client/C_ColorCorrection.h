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
	// MNotSaved
	Vector m_vecOrigin;
	// MNetworkEnable
	// MNotSaved
	float32 m_MinFalloff;
	// MNetworkEnable
	// MNotSaved
	float32 m_MaxFalloff;
	// MNetworkEnable
	// MNotSaved
	float32 m_flFadeInDuration;
	// MNetworkEnable
	// MNotSaved
	float32 m_flFadeOutDuration;
	// MNetworkEnable
	// MNotSaved
	float32 m_flMaxWeight;
	// MNetworkEnable
	// MNotSaved
	float32 m_flCurWeight;
	// MNetworkEnable
	// MNotSaved
	char[512] m_netlookupFilename;
	// MNetworkEnable
	// MNotSaved
	bool m_bEnabled;
	// MNetworkEnable
	// MNotSaved
	bool m_bMaster;
	// MNetworkEnable
	// MNotSaved
	bool m_bClientSide;
	// MNetworkEnable
	// MNotSaved
	bool m_bExclusive;
	// MNotSaved
	bool[1] m_bEnabledOnClient;
	// MNotSaved
	float32[1] m_flCurWeightOnClient;
	// MNotSaved
	bool[1] m_bFadingIn;
	// MNotSaved
	float32[1] m_flFadeStartWeight;
	// MNotSaved
	float32[1] m_flFadeStartTime;
	// MNotSaved
	float32[1] m_flFadeDuration;
};
