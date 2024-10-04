class CPointEntityFinder : public CBaseEntity
{
	CHandle< CBaseEntity > m_hEntity;
	CUtlSymbolLarge m_iFilterName;
	CHandle< CBaseFilter > m_hFilter;
	CUtlSymbolLarge m_iRefName;
	CHandle< CBaseEntity > m_hReference;
	EntFinderMethod_t m_FindMethod;
	CEntityIOOutput m_OnFoundEntity;
};
