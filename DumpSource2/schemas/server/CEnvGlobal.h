class CEnvGlobal : public CLogicalEntity
{
	CEntityOutputTemplate< int32 > m_outCounter;
	CUtlSymbolLarge m_globalstate;
	int32 m_triggermode;
	int32 m_initialstate;
	int32 m_counter;
}
