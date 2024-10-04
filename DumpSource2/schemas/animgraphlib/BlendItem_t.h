class BlendItem_t
{
	CUtlVector< TagSpan_t > m_tags;
	CAnimUpdateNodeRef m_pChild;
	HSequence m_hSequence;
	Vector2D m_vPos;
	float32 m_flDuration;
	bool m_bUseCustomDuration;
};
