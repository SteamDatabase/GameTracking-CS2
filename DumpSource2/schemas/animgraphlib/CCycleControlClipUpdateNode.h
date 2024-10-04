class CCycleControlClipUpdateNode : public CLeafUpdateNode
{
	CUtlVector< TagSpan_t > m_tags;
	HSequence m_hSequence;
	float32 m_duration;
	AnimValueSource m_valueSource;
	CAnimParamHandle m_paramIndex;
};
