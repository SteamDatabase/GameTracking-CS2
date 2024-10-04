class CMotionNodeSequence : public CMotionNode
{
	CUtlVector< TagSpan_t > m_tags;
	HSequence m_hSequence;
	float32 m_flPlaybackSpeed;
};
