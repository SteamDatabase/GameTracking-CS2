class CPathMover : public CPathWithDynamicNodes
{
	CUtlVector< CHandle< CFuncMover > > m_vecMovers;
	CHandle< CPathMoverEntitySpawner > m_hMoverSpawner;
	CUtlSymbolLarge m_iszMoverSpawnerName;
};
