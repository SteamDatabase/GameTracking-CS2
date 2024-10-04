class C_OP_RemapDistanceToLineSegmentBase : public CParticleFunctionOperator
{
	int32 m_nCP0;
	int32 m_nCP1;
	float32 m_flMinInputValue;
	float32 m_flMaxInputValue;
	bool m_bInfiniteLine;
};
