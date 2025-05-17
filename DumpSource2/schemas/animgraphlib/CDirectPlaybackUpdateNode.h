// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CDirectPlaybackUpdateNode : public CUnaryUpdateNode
{
	bool m_bFinishEarly;
	bool m_bResetOnFinish;
	CUtlVector< CDirectPlaybackTagData > m_allTags;
};
