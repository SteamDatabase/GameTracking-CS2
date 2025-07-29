class CMoverPathNode : public CPointEntity
{
	Vector m_vInTangentLocal;
	Vector m_vOutTangentLocal;
	CUtlSymbolLarge m_szParentPathUniqueID;
	CUtlSymbolLarge m_szPathNodeParameter;
	CEntityIOOutput m_OnStartFromOrInSegment;
	CEntityIOOutput m_OnStoppedAtOrInSegment;
	CEntityIOOutput m_OnPassThrough;
	CEntityIOOutput m_OnPassThroughForward;
	CEntityIOOutput m_OnPassThroughReverse;
	CHandle< CPathMover > m_hMover;
	CTransform m_xWSPrevParent;
};
