class CDestructiblePartsSystemData_PartData
{
	CUtlString m_sName;
	CGlobalSymbol m_sBreakablePieceName;
	CGlobalSymbol m_sBodyGroupName;
	int32 m_nBodyGroupValue;
	CGlobalSymbol m_sAnimGraphParamName_PartDestroyed;
	CGlobalSymbol m_sAnimGraphParamName_PartNormalizedHealth;
	CSkillInt m_nHealth;
	EDestructiblePartDamagePassThroughType m_nDamagePassthroughType;
	bool m_bKillNPCOnDestruction;
	CGlobalSymbol m_sCustomDeathHandshake;
};
