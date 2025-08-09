// MGetKV3ClassDefaults = {
//	"m_nShape": 0,
//	"m_fldbDrive": 0.000000,
//	"m_fldbOutputGain": 0.000000,
//	"m_flWetMix": 1.000000,
//	"m_nOversampleFactor": 1
//}
class VMixShaperDesc_t
{
	// MPropertyFriendlyName = "Shape"
	// MPropertyAttributeRange = "0 14"
	int32 m_nShape;
	// MPropertyFriendlyName = "Drive (dB)"
	// MPropertyAttributeRange = "0 36"
	float32 m_fldbDrive;
	// MPropertyFriendlyName = "Output Gain (dB)"
	// MPropertyAttributeRange = "-36 0"
	float32 m_fldbOutputGain;
	// MPropertyFriendlyName = "Dry/Wet"
	float32 m_flWetMix;
	// MPropertyFriendlyName = "Oversampling"
	int32 m_nOversampleFactor;
};
