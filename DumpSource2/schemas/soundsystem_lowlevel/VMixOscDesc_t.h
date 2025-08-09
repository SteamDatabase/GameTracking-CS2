// MGetKV3ClassDefaults = {
//	"oscType": "LFO_SHAPE_SINE",
//	"m_freq": 440.000000,
//	"m_flPhase": 0.000000
//}
class VMixOscDesc_t
{
	// MPropertyFriendlyName = "Type"
	VMixLFOShape_t oscType;
	// MPropertyFriendlyName = "Frequency (Hz)"
	// MPropertyAttributeRange = "0.1 16000"
	float32 m_freq;
	// MPropertyFriendlyName = "Phase (degrees)"
	// MPropertyAttributeRange = "0 360"
	float32 m_flPhase;
};
