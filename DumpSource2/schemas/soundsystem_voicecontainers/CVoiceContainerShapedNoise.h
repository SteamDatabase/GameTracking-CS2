// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MPropertyFriendlyName = "Wind Generator Container"
// MPropertyDescription = "This is a synth meant to generate whoosh noises."
class CVoiceContainerShapedNoise : public CVoiceContainerBase
{
	bool m_bUseCurveForFrequency;
	// MPropertySuppressExpr = "m_bUseCurveForFrequency == 1"
	float32 m_flFrequency;
	// MPropertySuppressExpr = "m_bUseCurveForFrequency == 0"
	// MPropertyFriendlyName = "Frequency Sweep"
	CPiecewiseCurve m_frequencySweep;
	bool m_bUseCurveForResonance;
	// MPropertySuppressExpr = "m_bUseCurveForResonance == 1"
	float32 m_flResonance;
	// MPropertySuppressExpr = "m_bUseCurveForResonance == 0"
	// MPropertyFriendlyName = "Resonance Sweep"
	CPiecewiseCurve m_resonanceSweep;
	bool m_bUseCurveForAmplitude;
	// MPropertySuppressExpr = "m_bUseCurveForAmplitude == 1"
	float32 m_flGainInDecibels;
	// MPropertySuppressExpr = "m_bUseCurveForAmplitude == 0"
	// MPropertyFriendlyName = "Gain Sweep (in Decibels)"
	CPiecewiseCurve m_gainSweep;
};
