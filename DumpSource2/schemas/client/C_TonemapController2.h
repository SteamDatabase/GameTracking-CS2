// MEntityAllowsPortraitWorldSpawn
// MNetworkVarNames = "float m_flAutoExposureMin"
// MNetworkVarNames = "float m_flAutoExposureMax"
// MNetworkVarNames = "float m_flExposureAdaptationSpeedUp"
// MNetworkVarNames = "float m_flExposureAdaptationSpeedDown"
// MNetworkVarNames = "float m_flTonemapEVSmoothingRange"
class C_TonemapController2 : public C_BaseEntity
{
	// MNetworkEnable
	float32 m_flAutoExposureMin;
	// MNetworkEnable
	float32 m_flAutoExposureMax;
	// MNetworkEnable
	float32 m_flExposureAdaptationSpeedUp;
	// MNetworkEnable
	float32 m_flExposureAdaptationSpeedDown;
	// MNetworkEnable
	float32 m_flTonemapEVSmoothingRange;
};
