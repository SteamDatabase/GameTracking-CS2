class CPathMover : public CBaseEntity
{
	CUtlVector< CHandle< CMoverPathNode > > m_vecPathNodes;
	float32 m_flPathLength;
	bool m_bClosedLoop;
};
