class CWayPointHelperUpdateNode : public CUnaryUpdateNode
{
	float32 m_flStartCycle;
	float32 m_flEndCycle;
	bool m_bOnlyGoals;
	bool m_bPreventOvershoot;
	bool m_bPreventUndershoot;
};
