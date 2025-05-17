// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MPropertyFriendlyName = "TESTBED: FM Synth Container"
// MPropertyDescription = "Real time FM Synthesis"
class CVoiceContainerRealtimeFMSineWave : public CVoiceContainerBase
{
	// MPropertyFriendlyName = "Frequency (Hz)"
	// MPropertyDescription = "The frequency of this sine tone."
	float32 m_flCarrierFrequency;
	// MPropertyFriendlyName = "Mod Frequency (Hz)"
	// MPropertyDescription = "The frequency of the sine tone modulating this sine tone."
	float32 m_flModulatorFrequency;
	// MPropertyFriendlyName = "Mod Amount (Hz)"
	// MPropertyDescription = "The amount the modulating sine tone modulates this sine tone."
	float32 m_flModulatorAmount;
};
