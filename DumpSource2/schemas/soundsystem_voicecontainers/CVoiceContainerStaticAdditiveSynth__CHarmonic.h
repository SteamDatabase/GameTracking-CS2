class CVoiceContainerStaticAdditiveSynth::CHarmonic
{
	EWaveform m_nWaveform;
	EMidiNote m_nFundamental;
	int32 m_nOctave;
	float32 m_flCents;
	float32 m_flPhase;
	CPiecewiseCurve m_curve;
	CVoiceContainerStaticAdditiveSynth::CGainScalePerInstance m_volumeScaling;
};
