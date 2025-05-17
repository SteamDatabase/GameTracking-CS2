// MEntityAllowsPortraitWorldSpawn
// MNetworkVarNames = "float m_flAutoExposureMin"
// MNetworkVarNames = "float m_flAutoExposureMax"
// MNetworkVarNames = "float m_flTonemapPercentTarget"
// MNetworkVarNames = "float m_flTonemapPercentBrightPixels"
// MNetworkVarNames = "float m_flTonemapMinAvgLum"
// MNetworkVarNames = "float m_flExposureAdaptationSpeedUp"
// MNetworkVarNames = "float m_flExposureAdaptationSpeedDown"
// MNetworkVarNames = "float m_flTonemapEVSmoothingRange"
class CTonemapController2 : public CBaseEntity
{
	// MNetworkEnable
	float32 m_flAutoExposureMin;
	// MNetworkEnable
	float32 m_flAutoExposureMax;
	// MNetworkEnable
	float32 m_flTonemapPercentTarget;
	// MNetworkEnable
	float32 m_flTonemapPercentBrightPixels;
	// MNetworkEnable
	float32 m_flTonemapMinAvgLum;
	// MNetworkEnable
	float32 m_flExposureAdaptationSpeedUp;
	// MNetworkEnable
	float32 m_flExposureAdaptationSpeedDown;
	// MNetworkEnable
	float32 m_flTonemapEVSmoothingRange;
};
