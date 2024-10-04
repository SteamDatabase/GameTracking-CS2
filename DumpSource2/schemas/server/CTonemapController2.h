class CTonemapController2 : public CBaseEntity
{
	float32 m_flAutoExposureMin;
	float32 m_flAutoExposureMax;
	float32 m_flTonemapPercentTarget;
	float32 m_flTonemapPercentBrightPixels;
	float32 m_flTonemapMinAvgLum;
	float32 m_flExposureAdaptationSpeedUp;
	float32 m_flExposureAdaptationSpeedDown;
	float32 m_flTonemapEVSmoothingRange;
};
