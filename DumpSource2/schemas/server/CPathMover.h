class CPathMover : public CPathSimple
{
	CUtlVector< CHandle< CMoverPathNode > > m_vecPathNodes;
	CUtlVector< CHandle< CFuncMover > > m_vecMovers;
	CTransform m_xInitialPathWorldToLocal;
};
