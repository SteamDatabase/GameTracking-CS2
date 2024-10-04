class CVoiceContainerLoopTrigger : public CVoiceContainerBase
{
	CSoundContainerReference m_sound;
	float32 m_flRetriggerTimeMin;
	float32 m_flRetriggerTimeMax;
	float32 m_flFadeTime;
	bool m_bCrossFade;
};
