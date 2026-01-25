class CLogicLineToEntity : public CLogicalEntity
{
	CEntityOutputTemplate< Vector, Vector > m_Line;
	CUtlSymbolLarge m_SourceName;
	CHandle< CBaseEntity > m_StartEntity;
	CHandle< CBaseEntity > m_EndEntity;
};
