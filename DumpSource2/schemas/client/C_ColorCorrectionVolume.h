// MNetworkVarNames = "bool m_bEnabled"
// MNetworkVarNames = "float m_MaxWeight"
// MNetworkVarNames = "float m_FadeDuration"
// MNetworkVarNames = "float m_Weight"
// MNetworkVarNames = "char m_lookupFilename"
class C_ColorCorrectionVolume : public C_BaseTrigger
{
	// MNotSaved
	float32 m_LastEnterWeight;
	// MNotSaved
	GameTime_t m_LastEnterTime;
	// MNotSaved
	float32 m_LastExitWeight;
	// MNotSaved
	GameTime_t m_LastExitTime;
	// MNetworkEnable
	// MNotSaved
	bool m_bEnabled;
	// MNetworkEnable
	// MNotSaved
	float32 m_MaxWeight;
	// MNetworkEnable
	// MNotSaved
	float32 m_FadeDuration;
	// MNetworkEnable
	// MNotSaved
	float32 m_Weight;
	// MNetworkEnable
	// MNotSaved
	char[512] m_lookupFilename;
};
