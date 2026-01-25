class CEnvSoundscape : public C_BaseEntity
{
	CEntityIOOutput m_OnPlay;
	float32 m_flRadius;
	CUtlSymbolLarge m_soundEventName;
	bool m_bOverrideWithEvent;
	// MNotSaved
	int32 m_soundscapeIndex;
	// MNotSaved
	int32 m_soundscapeEntityListId;
	CUtlSymbolLarge[8] m_positionNames;
	CHandle< CEnvSoundscape > m_hProxySoundscape;
	bool m_bDisabled;
	CUtlSymbolLarge m_soundscapeName;
	// MNotSaved
	uint32 m_soundEventHash;
};
