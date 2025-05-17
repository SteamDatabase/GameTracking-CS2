// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MPropertyFriendlyName = "Container Set"
// MPropertyDescription = "An array of containers that are played all at once."
class CVoiceContainerSet : public CVoiceContainerBase
{
	// MPropertyFriendlyName = "Container List"
	CUtlVector< CVoiceContainerSetElement > m_soundsToPlay;
};
