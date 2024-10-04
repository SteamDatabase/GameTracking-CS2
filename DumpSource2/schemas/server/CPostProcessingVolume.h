class CPostProcessingVolume : public CBaseTrigger
{
	CStrongHandle< InfoForResourceTypeCPostProcessingResource > m_hPostSettings;
	float32 m_flFadeDuration;
	float32 m_flMinLogExposure;
	float32 m_flMaxLogExposure;
	float32 m_flMinExposure;
	float32 m_flMaxExposure;
	float32 m_flExposureCompensation;
	float32 m_flExposureFadeSpeedUp;
	float32 m_flExposureFadeSpeedDown;
	float32 m_flTonemapEVSmoothingRange;
	bool m_bMaster;
	bool m_bExposureControl;
	float32 m_flRate;
	float32 m_flTonemapPercentTarget;
	float32 m_flTonemapPercentBrightPixels;
	float32 m_flTonemapMinAvgLum;
}
