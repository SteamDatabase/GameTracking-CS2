// MEntityAllowsPortraitWorldSpawn
// MNetworkVarNames = "HPostProcessingStrong m_hPostSettings"
// MNetworkVarNames = "float m_flFadeDuration"
// MNetworkVarNames = "float m_flMinLogExposure"
// MNetworkVarNames = "float m_flMaxLogExposure"
// MNetworkVarNames = "float m_flMinExposure"
// MNetworkVarNames = "float m_flMaxExposure"
// MNetworkVarNames = "float m_flExposureCompensation"
// MNetworkVarNames = "float m_flExposureFadeSpeedUp"
// MNetworkVarNames = "float m_flExposureFadeSpeedDown"
// MNetworkVarNames = "float m_flTonemapEVSmoothingRange"
// MNetworkVarNames = "bool m_bMaster"
// MNetworkVarNames = "bool m_bExposureControl"
class CPostProcessingVolume : public CBaseTrigger
{
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeCPostProcessingResource > m_hPostSettings;
	// MNetworkEnable
	float32 m_flFadeDuration;
	// MNetworkEnable
	float32 m_flMinLogExposure;
	// MNetworkEnable
	float32 m_flMaxLogExposure;
	// MNetworkEnable
	float32 m_flMinExposure;
	// MNetworkEnable
	float32 m_flMaxExposure;
	// MNetworkEnable
	float32 m_flExposureCompensation;
	// MNetworkEnable
	float32 m_flExposureFadeSpeedUp;
	// MNetworkEnable
	float32 m_flExposureFadeSpeedDown;
	// MNetworkEnable
	float32 m_flTonemapEVSmoothingRange;
	// MNetworkEnable
	bool m_bMaster;
	// MNetworkEnable
	bool m_bExposureControl;
};
