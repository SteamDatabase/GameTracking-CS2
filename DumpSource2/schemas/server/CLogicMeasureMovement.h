class CLogicMeasureMovement : public CLogicalEntity
{
	CUtlSymbolLarge m_strMeasureTarget;
	CUtlSymbolLarge m_strMeasureReference;
	CUtlSymbolLarge m_strTargetReference;
	CHandle< CBaseEntity > m_hMeasureTarget;
	CHandle< CBaseEntity > m_hMeasureReference;
	CHandle< CBaseEntity > m_hTarget;
	CHandle< CBaseEntity > m_hTargetReference;
	float32 m_flScale;
	int32 m_nMeasureType;
};
