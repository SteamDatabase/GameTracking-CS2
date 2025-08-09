// MGetKV3ClassDefaults = Could not parse KV3 Defaults
class CBinaryUpdateNode : public CAnimUpdateNodeBase
{
	CAnimUpdateNodeRef m_pChild1;
	CAnimUpdateNodeRef m_pChild2;
	BinaryNodeTiming m_timingBehavior;
	float32 m_flTimingBlend;
	bool m_bResetChild1;
	bool m_bResetChild2;
};
