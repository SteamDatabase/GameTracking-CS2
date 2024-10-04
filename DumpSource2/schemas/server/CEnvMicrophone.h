class CEnvMicrophone : public CPointEntity
{
	bool m_bDisabled;
	CHandle< CBaseEntity > m_hMeasureTarget;
	SoundTypes_t m_nSoundType;
	SoundFlags_t m_nSoundFlags;
	float32 m_flSensitivity;
	float32 m_flSmoothFactor;
	float32 m_flMaxRange;
	CUtlSymbolLarge m_iszSpeakerName;
	CHandle< CBaseEntity > m_hSpeaker;
	bool m_bAvoidFeedback;
	int32 m_iSpeakerDSPPreset;
	CUtlSymbolLarge m_iszListenFilter;
	CHandle< CBaseFilter > m_hListenFilter;
	CEntityOutputTemplate< float32 > m_SoundLevel;
	CEntityIOOutput m_OnRoutedSound;
	CEntityIOOutput m_OnHeardSound;
	char[256] m_szLastSound;
	int32 m_iLastRoutedFrame;
}
