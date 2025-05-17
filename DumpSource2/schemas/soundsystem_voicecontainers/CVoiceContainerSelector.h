// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MPropertyFriendlyName = "Selector"
// MPropertyDescription = "Plays a selected vsnd on playback."
class CVoiceContainerSelector : public CVoiceContainerBase
{
	// MPropertyFriendlyName = "Playback Mode"
	PlayBackMode_t m_mode;
	// MPropertyFriendlyName = "Sounds To play"
	CSoundContainerReferenceArray m_soundsToPlay;
	// MPropertyFriendlyName = "Relative Weights"
	CUtlVector< float32 > m_fProbabilityWeights;
};
