class CFilterMultiple : public CBaseFilter
{
	filter_t m_nFilterType;
	CUtlSymbolLarge[10] m_iFilterName;
	CHandle< CBaseEntity >[10] m_hFilter;
	int32 m_nFilterCount;
}
