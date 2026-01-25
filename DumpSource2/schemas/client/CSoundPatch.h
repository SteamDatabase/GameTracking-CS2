class CSoundPatch
{
	CSoundEnvelope m_pitch;
	CSoundEnvelope m_volume;
	float32 m_shutdownTime;
	float32 m_flLastTime;
	CUtlSymbolLarge m_iszSoundScriptName;
	CHandle< C_BaseEntity > m_hEnt;
	// MNotSaved
	CEntityIndex m_soundEntityIndex;
	// MNotSaved
	Vector m_soundOrigin;
	int32 m_isPlaying;
	CCopyRecipientFilter m_Filter;
	float32 m_flCloseCaptionDuration;
	// MNotSaved
	bool m_bUpdatedSoundOrigin;
	// MNotSaved
	CUtlSymbolLarge m_iszClassName;
};
