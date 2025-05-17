// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MPropertyFriendlyName = "Envelope Analyzer"
// MPropertyDescription = "Generates an Envelope Curve on compile"
class CVoiceContainerEnvelopeAnalyzer : public CVoiceContainerAnalysisBase
{
	// MPropertyFriendlyName = "Envelope Mode"
	EMode_t m_mode;
	// MPropertyFriendlyName = "Number of sections"
	int32 m_nSamples;
	// MPropertyFriendlyName = "Threshold"
	float32 m_flThreshold;
};
