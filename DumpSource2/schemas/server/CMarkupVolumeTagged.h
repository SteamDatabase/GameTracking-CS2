class CMarkupVolumeTagged : public CMarkupVolume
{
	CUtlVector< CGlobalSymbol > m_GroupNames;
	CUtlVector< CGlobalSymbol > m_Tags;
	bool m_bIsGroup;
	bool m_bGroupByPrefab;
	bool m_bGroupByVolume;
	bool m_bGroupOtherGroups;
	bool m_bIsInGroup;
};
