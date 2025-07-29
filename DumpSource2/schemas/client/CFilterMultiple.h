class CFilterMultiple : public CBaseFilter
{
	filter_t m_nFilterType;
	CUtlSymbolLarge[10] m_iFilterName;
	CHandle< C_BaseEntity >[10] m_hFilter;
};
