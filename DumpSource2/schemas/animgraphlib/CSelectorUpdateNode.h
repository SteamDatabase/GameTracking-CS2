class CSelectorUpdateNode : public CAnimUpdateNodeBase
{
	CUtlVector< CAnimUpdateNodeRef > m_children;
	CUtlVector< int8 > m_tags;
	CBlendCurve m_blendCurve;
	CAnimValue< float32 > m_flBlendTime;
	CAnimParamHandle m_hParameter;
	int32 m_nTagIndex;
	SelectorTagBehavior_t m_eTagBehavior;
	bool m_bResetOnChange;
	bool m_bLockWhenWaning;
	bool m_bSyncCyclesOnChange;
}
