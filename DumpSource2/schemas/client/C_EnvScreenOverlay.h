// MNetworkVarNames = "string_t m_iszOverlayNames"
// MNetworkVarNames = "float32 m_flOverlayTimes"
// MNetworkVarNames = "GameTime_t m_flStartTime"
// MNetworkVarNames = "int32 m_iDesiredOverlay"
// MNetworkVarNames = "bool m_bIsActive"
class C_EnvScreenOverlay : public C_PointEntity
{
	// MNetworkEnable
	CUtlSymbolLarge[10] m_iszOverlayNames;
	// MNetworkEnable
	// MNetworkBitCount = 11
	// MNetworkMinValue = -1.000000
	// MNetworkMaxValue = 63.000000
	float32[10] m_flOverlayTimes;
	// MNetworkEnable
	GameTime_t m_flStartTime;
	// MNetworkEnable
	int32 m_iDesiredOverlay;
	// MNetworkEnable
	bool m_bIsActive;
	bool m_bWasActive;
	int32 m_iCachedDesiredOverlay;
	int32 m_iCurrentOverlay;
	GameTime_t m_flCurrentOverlayTime;
};
