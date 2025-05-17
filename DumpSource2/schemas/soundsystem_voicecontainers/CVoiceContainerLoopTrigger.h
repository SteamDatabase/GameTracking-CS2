// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MPropertyFriendlyName = "LoopTrigger"
// MPropertyDescription = "Continuously retriggers a sound and optionally fades to the new instance."
class CVoiceContainerLoopTrigger : public CVoiceContainerBase
{
	// MPropertyFriendlyName = "Vsnd Reference"
	CSoundContainerReference m_sound;
	float32 m_flRetriggerTimeMin;
	float32 m_flRetriggerTimeMax;
	float32 m_flFadeTime;
	bool m_bCrossFade;
};
