class CMoverPathNode : public CPathNode
{
	CEntityOutputTemplate< CUtlString, char* > m_OnStartFromOrInSegment;
	CEntityOutputTemplate< CUtlString, char* > m_OnStoppedAtOrInSegment;
	CEntityOutputTemplate< CUtlString, char* > m_OnPassThrough;
	CEntityOutputTemplate< CUtlString, char* > m_OnPassThroughForward;
	CEntityOutputTemplate< CUtlString, char* > m_OnPassThroughReverse;
};
