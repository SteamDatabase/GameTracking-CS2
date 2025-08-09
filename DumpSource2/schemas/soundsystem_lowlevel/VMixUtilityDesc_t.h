// MGetKV3ClassDefaults = {
//	"m_nOp": "VMIX_CHAN_STEREO",
//	"m_flInputPan": 0.000000,
//	"m_flOutputBalance": 0.000000,
//	"m_fldbOutputGain": 0.000000,
//	"m_bBassMono": false,
//	"m_flBassFreq": 120.000000
//}
class VMixUtilityDesc_t
{
	// MPropertyFriendlyName = "Channels"
	VMixChannelOperation_t m_nOp;
	// MPropertyFriendlyName = "Input Pan"
	// MPropertyAttributeRange = "-1 1"
	float32 m_flInputPan;
	// MPropertyFriendlyName = "Output Balance"
	// MPropertyAttributeRange = "-1 1"
	float32 m_flOutputBalance;
	// MPropertyFriendlyName = "Output Gain (dB)"
	// MPropertyAttributeRange = "-36 0"
	float32 m_fldbOutputGain;
	bool m_bBassMono;
	float32 m_flBassFreq;
};
