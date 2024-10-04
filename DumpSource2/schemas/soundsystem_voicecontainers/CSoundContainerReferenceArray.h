class CSoundContainerReferenceArray
{
	bool m_bUseReference;
	CUtlVector< CStrongHandle< InfoForResourceTypeCVoiceContainerBase > > m_sounds;
	CUtlVector< CVoiceContainerBase* > m_pSounds;
};
