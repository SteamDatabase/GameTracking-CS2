// MNetworkVarNames = "bool m_bEnabled"
// MNetworkVarNames = "float32 m_MaxWeight"
// MNetworkVarNames = "float32 m_FadeDuration"
// MNetworkVarNames = "float32 m_Weight"
// MNetworkVarNames = "char m_lookupFilename"
class CColorCorrectionVolume : public CBaseTrigger
{
	// MNetworkEnable
	bool m_bEnabled;
	// MNetworkEnable
	float32 m_MaxWeight;
	// MNetworkEnable
	float32 m_FadeDuration;
	bool m_bStartDisabled;
	// MNetworkEnable
	float32 m_Weight;
	// MNetworkEnable
	char[512] m_lookupFilename;
	float32 m_LastEnterWeight;
	GameTime_t m_LastEnterTime;
	float32 m_LastExitWeight;
	GameTime_t m_LastExitTime;
};
