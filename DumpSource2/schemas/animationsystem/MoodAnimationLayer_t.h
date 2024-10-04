class MoodAnimationLayer_t
{
	CUtlString m_sName;
	bool m_bActiveListening;
	bool m_bActiveTalking;
	CUtlVector< MoodAnimation_t > m_layerAnimations;
	CRangeFloat m_flIntensity;
	CRangeFloat m_flDurationScale;
	bool m_bScaleWithInts;
	CRangeFloat m_flNextStart;
	CRangeFloat m_flStartOffset;
	CRangeFloat m_flEndOffset;
	float32 m_flFadeIn;
	float32 m_flFadeOut;
};
