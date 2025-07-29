// MPulseInstanceDomainInfo (UNKNOWN FOR PARSER)
// MPulseDomainHookInfo (UNKNOWN FOR PARSER)
// MPulseDomainScopeInfo (UNKNOWN FOR PARSER)
// MPulseLibraryBindings (UNKNOWN FOR PARSER)
// MPulseDomainOptInFeatureTag (UNKNOWN FOR PARSER)
// MPulseDomainOptInVariableKeysSource (UNKNOWN FOR PARSER)
// MPulseDomainDebuggerCanCreateInstance
class CPulseGraphInstance_TestDomain : public CBasePulseGraphInstance
{
	bool m_bIsRunningUnitTests;
	bool m_bExplicitTimeStepping;
	bool m_bExpectingToDestroyWithYieldedCursors;
	bool m_bQuietTracepoints;
	bool m_bExpectingCursorTerminatedDueToMaxInstructions;
	int32 m_nCursorsTerminatedDueToMaxInstructions;
	int32 m_nNextValidateIndex;
	CUtlVector< CUtlString > m_Tracepoints;
	bool m_bTestYesOrNoPath;
};
