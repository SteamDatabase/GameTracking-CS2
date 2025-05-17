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
// MNetworkVarNames = "Vector m_location"
// MNetworkVarNames = "uint16 m_iInitialWindDir"
// MNetworkVarNames = "float32 m_flInitialWindSpeed"
class C_EnvWindShared
{
	// MNetworkEnable
	GameTime_t m_flStartTime;
	// MNetworkEnable
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
	// MNetworkEncoder = "coord"
	Vector m_location;
	int32 m_iszGustSound;
	int32 m_iWindDir;
	float32 m_flWindSpeed;
	Vector m_currentWindVector;
	Vector m_CurrentSwayVector;
	Vector m_PrevSwayVector;
	// MNetworkEnable
	uint16 m_iInitialWindDir;
	// MNetworkEnable
	float32 m_flInitialWindSpeed;
	GameTime_t m_flVariationTime;
	GameTime_t m_flSwayTime;
	GameTime_t m_flSimTime;
	GameTime_t m_flSwitchTime;
	float32 m_flAveWindSpeed;
	bool m_bGusting;
	float32 m_flWindAngleVariation;
	float32 m_flWindSpeedVariation;
	CHandle< C_BaseEntity > m_hEntOwner;
};
