// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CBlend2DUpdateNode : public CAnimUpdateNodeBase
{
	CUtlVector< BlendItem_t > m_items;
	CUtlVector< TagSpan_t > m_tags;
	CParamSpanUpdater m_paramSpans;
	CUtlVector< int32 > m_nodeItemIndices;
	CAnimInputDamping m_damping;
	AnimValueSource m_blendSourceX;
	CAnimParamHandle m_paramX;
	AnimValueSource m_blendSourceY;
	CAnimParamHandle m_paramY;
	Blend2DMode m_eBlendMode;
	float32 m_playbackSpeed;
	bool m_bLoop;
	bool m_bLockBlendOnReset;
	bool m_bLockWhenWaning;
	bool m_bAnimEventsAndTagsOnMostWeightedOnly;
};
