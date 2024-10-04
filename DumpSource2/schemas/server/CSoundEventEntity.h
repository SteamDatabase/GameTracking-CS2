class CSoundEventEntity : public CBaseEntity
{
	bool m_bStartOnSpawn;
	bool m_bToLocalPlayer;
	bool m_bStopOnNew;
	bool m_bSaveRestore;
	bool m_bSavedIsPlaying;
	float32 m_flSavedElapsedTime;
	CUtlSymbolLarge m_iszSourceEntityName;
	CUtlSymbolLarge m_iszAttachmentName;
	CEntityOutputTemplate< uint64 > m_onGUIDChanged;
	CEntityIOOutput m_onSoundFinished;
	float32 m_flClientCullRadius;
	CUtlSymbolLarge m_iszSoundName;
	CEntityHandle m_hSource;
	int32 m_nEntityIndexSelection;
}
