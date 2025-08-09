// MGetKV3ClassDefaults = {
//	"m_fldbGain": 0.000000,
//	"m_fldbNoiseGateThreshold": 0.000000,
//	"m_fldbCompressionThreshold": 0.000000,
//	"m_fldbLimiterThreshold": 0.000000,
//	"m_fldbKneeWidth": 0.000000,
//	"m_flRatio": 0.000000,
//	"m_flLimiterRatio": 0.000000,
//	"m_flAttackTimeMS": 0.000000,
//	"m_flReleaseTimeMS": 0.000000,
//	"m_flRMSTimeMS": 0.000000,
//	"m_flWetMix": 0.000000,
//	"m_bPeakMode": false
//}
class VMixDynamicsDesc_t
{
	float32 m_fldbGain;
	float32 m_fldbNoiseGateThreshold;
	float32 m_fldbCompressionThreshold;
	float32 m_fldbLimiterThreshold;
	float32 m_fldbKneeWidth;
	float32 m_flRatio;
	float32 m_flLimiterRatio;
	float32 m_flAttackTimeMS;
	float32 m_flReleaseTimeMS;
	float32 m_flRMSTimeMS;
	float32 m_flWetMix;
	bool m_bPeakMode;
};
