class CMoverPathNode : public CPointEntity
{
	Vector m_vInTangentLocal;
	Vector m_vOutTangentLocal;
	CUtlSymbolLarge m_szParentPathUniqueID;
	CEntityIOOutput m_OnPassThrough;
	CEntityIOOutput m_OnPassThroughForward;
	CEntityIOOutput m_OnPassThroughReverse;
	CHandle< CPathMover > m_hMover;
};
