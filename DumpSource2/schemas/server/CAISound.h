class CAISound : public CPointEntity
{
	SoundTypes_t m_iSoundType;
	SoundFlags_t m_iSoundFlags;
	int32 m_iVolume;
	int32 m_iSoundIndex;
	float32 m_flDuration;
	CUtlSymbolLarge m_iszProxyEntityName;
}
