class CEnvSoundscape : public CServerOnlyEntity
{
	CEntityIOOutput m_OnPlay;
	float32 m_flRadius;
	CUtlSymbolLarge m_soundscapeName;
	CUtlSymbolLarge m_soundEventName;
	bool m_bOverrideWithEvent;
	int32 m_soundscapeIndex;
	int32 m_soundscapeEntityListId;
	uint32 m_soundEventHash;
	CUtlSymbolLarge[8] m_positionNames;
	CHandle< CEnvSoundscape > m_hProxySoundscape;
	bool m_bDisabled;
}
