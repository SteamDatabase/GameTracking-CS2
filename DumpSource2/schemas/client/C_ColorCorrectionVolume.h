// MNetworkVarNames = "bool m_bEnabled"
// MNetworkVarNames = "float m_MaxWeight"
// MNetworkVarNames = "float m_FadeDuration"
// MNetworkVarNames = "float m_Weight"
// MNetworkVarNames = "char m_lookupFilename"
class C_ColorCorrectionVolume : public C_BaseTrigger
{
	float32 m_LastEnterWeight;
	GameTime_t m_LastEnterTime;
	float32 m_LastExitWeight;
	GameTime_t m_LastExitTime;
	// MNetworkEnable
	bool m_bEnabled;
	// MNetworkEnable
	float32 m_MaxWeight;
	// MNetworkEnable
	float32 m_FadeDuration;
	// MNetworkEnable
	float32 m_Weight;
	// MNetworkEnable
	char[512] m_lookupFilename;
};
