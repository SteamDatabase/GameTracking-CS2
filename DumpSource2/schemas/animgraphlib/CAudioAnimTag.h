class CAudioAnimTag : public CAnimTagBase
{
	CUtlString m_clipName;
	CUtlString m_attachmentName;
	float32 m_flVolume;
	bool m_bStopWhenTagEnds;
	bool m_bStopWhenGraphEnds;
	bool m_bPlayOnServer;
	bool m_bPlayOnClient;
};
