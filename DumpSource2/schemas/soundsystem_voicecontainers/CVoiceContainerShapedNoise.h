class CVoiceContainerShapedNoise : public CVoiceContainerBase
{
	bool m_bUseCurveForFrequency;
	float32 m_flFrequency;
	CPiecewiseCurve m_frequencySweep;
	bool m_bUseCurveForResonance;
	float32 m_flResonance;
	CPiecewiseCurve m_resonanceSweep;
	bool m_bUseCurveForAmplitude;
	float32 m_flGainInDecibels;
	CPiecewiseCurve m_gainSweep;
};
