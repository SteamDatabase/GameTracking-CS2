class CPulseGraphInstance_TestDomain : public CBasePulseGraphInstance
{
	bool m_bIsRunningUnitTests;
	bool m_bExplicitTimeStepping;
	bool m_bExpectingToDestroyWithYieldedCursors;
	int32 m_nNextValidateIndex;
	CUtlVector< CUtlString > m_Tracepoints;
	bool m_bTestYesOrNoPath;
}
