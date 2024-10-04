class CAmbientGeneric : public CPointEntity
{
	float32 m_radius;
	float32 m_flMaxRadius;
	soundlevel_t m_iSoundLevel;
	dynpitchvol_t m_dpv;
	bool m_fActive;
	bool m_fLooping;
	CUtlSymbolLarge m_iszSound;
	CUtlSymbolLarge m_sSourceEntName;
	CHandle< CBaseEntity > m_hSoundSource;
	CEntityIndex m_nSoundSourceEntIndex;
}
