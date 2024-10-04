class CSoundOpvarSetEntity : public CBaseEntity
{
	CUtlSymbolLarge m_iszStackName;
	CUtlSymbolLarge m_iszOperatorName;
	CUtlSymbolLarge m_iszOpvarName;
	int32 m_nOpvarType;
	int32 m_nOpvarIndex;
	float32 m_flOpvarValue;
	CUtlSymbolLarge m_OpvarValueString;
	bool m_bSetOnSpawn;
}
