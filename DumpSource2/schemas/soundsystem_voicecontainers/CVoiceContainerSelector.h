class CVoiceContainerSelector : public CVoiceContainerBase
{
	PlayBackMode_t m_mode;
	CSoundContainerReferenceArray m_soundsToPlay;
	CUtlVector< float32 > m_fProbabilityWeights;
};
