// MNetworkVarNames = "GameTime_t m_flStartTime"
// MNetworkVarNames = "uint32 m_iWindSeed"
// MNetworkVarNames = "uint16 m_iMinWind"
// MNetworkVarNames = "uint16 m_iMaxWind"
// MNetworkVarNames = "int32 m_windRadius"
// MNetworkVarNames = "uint16 m_iMinGust"
// MNetworkVarNames = "uint16 m_iMaxGust"
// MNetworkVarNames = "float32 m_flMinGustDelay"
// MNetworkVarNames = "float32 m_flMaxGustDelay"
// MNetworkVarNames = "float32 m_flGustDuration"
// MNetworkVarNames = "uint16 m_iGustDirChange"
// MNetworkVarNames = "uint16 m_iInitialWindDir"
// MNetworkVarNames = "float32 m_flInitialWindSpeed"
// MNetworkVarNames = "Vector m_location"
class C_EnvWindShared
{
	// MNetworkEnable
	// MNotSaved
	GameTime_t m_flStartTime;
	// MNetworkEnable
	// MNotSaved
	uint32 m_iWindSeed;
	// MNetworkEnable
	uint16 m_iMinWind;
	// MNetworkEnable
	uint16 m_iMaxWind;
	// MNetworkEnable
	int32 m_windRadius;
	// MNetworkEnable
	uint16 m_iMinGust;
	// MNetworkEnable
	uint16 m_iMaxGust;
	// MNetworkEnable
	float32 m_flMinGustDelay;
	// MNetworkEnable
	float32 m_flMaxGustDelay;
	// MNetworkEnable
	float32 m_flGustDuration;
	// MNetworkEnable
	uint16 m_iGustDirChange;
	// MNetworkEnable
	// MNotSaved
	uint16 m_iInitialWindDir;
	// MNetworkEnable
	// MNotSaved
	float32 m_flInitialWindSpeed;
	// MNetworkEnable
	// MNetworkEncoder = "coord"
	// MNotSaved
	Vector m_location;
	// MNotSaved
	CHandle< C_BaseEntity > m_hEntOwner;
};
