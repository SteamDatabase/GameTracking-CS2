class CSoundOpvarSetPointBase : public CBaseEntity
{
	bool m_bDisabled;
	CEntityHandle m_hSource;
	CUtlSymbolLarge m_iszSourceEntityName;
	Vector m_vLastPosition;
	CUtlSymbolLarge m_iszStackName;
	CUtlSymbolLarge m_iszOperatorName;
	CUtlSymbolLarge m_iszOpvarName;
	int32 m_iOpvarIndex;
	bool m_bUseAutoCompare;
};
