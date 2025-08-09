// MGetKV3ClassDefaults = {
//	"m_nWaveform": "Sine",
//	"m_nFundamental": "A",
//	"m_nOctave": 4,
//	"m_flCents": 0.000000,
//	"m_flPhase": 0.000000,
//	"m_curve":
//	{
//		"m_spline":
//		[
//		],
//		"m_tangents":
//		[
//		],
//		"m_vDomainMins":
//		[
//			0.000000,
//			0.000000
//		],
//		"m_vDomainMaxs":
//		[
//			0.000000,
//			0.000000
//		]
//	},
//	"m_volumeScaling":
//	{
//		"m_flMinVolume": 1.000000,
//		"m_nInstancesAtMinVolume": 1,
//		"m_flMaxVolume": 1.000000,
//		"m_nInstancesAtMaxVolume": 1
//	}
//}
class CVoiceContainerStaticAdditiveSynth::CHarmonic
{
	// MPropertyFriendlyName = "Waveform"
	EWaveform m_nWaveform;
	// MPropertyFriendlyName = "Note"
	EMidiNote m_nFundamental;
	// MPropertyFriendlyName = "Octave"
	int32 m_nOctave;
	// MPropertyFriendlyName = "Cents To Detune ( -100:100 )"
	float32 m_flCents;
	// MPropertyFriendlyName = "Phase ( 0 - 1 )"
	float32 m_flPhase;
	// MPropertyFriendlyName = "Envelope (Relative to Tone Envelope)"
	CPiecewiseCurve m_curve;
	CVoiceContainerStaticAdditiveSynth::CGainScalePerInstance m_volumeScaling;
};
