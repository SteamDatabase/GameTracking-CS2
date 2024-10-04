class CSoundPatch
{
	CSoundEnvelope m_pitch;
	CSoundEnvelope m_volume;
	float32 m_shutdownTime;
	float32 m_flLastTime;
	CUtlSymbolLarge m_iszSoundScriptName;
	CHandle< C_BaseEntity > m_hEnt;
	CEntityIndex m_soundEntityIndex;
	Vector m_soundOrigin;
	int32 m_isPlaying;
	CCopyRecipientFilter m_Filter;
	float32 m_flCloseCaptionDuration;
	bool m_bUpdatedSoundOrigin;
	CUtlSymbolLarge m_iszClassName;
};
