class CVoiceContainerStaticAdditiveSynth::CTone
{
	CUtlVector< CVoiceContainerStaticAdditiveSynth::CHarmonic > m_harmonics;
	CPiecewiseCurve m_curve;
	bool m_bSyncInstances;
};
