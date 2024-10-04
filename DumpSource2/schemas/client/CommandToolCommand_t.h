class CommandToolCommand_t
{
	bool m_bEnabled;
	bool m_bOpened;
	uint32 m_InternalId;
	CUtlString m_ShortName;
	CommandExecMode_t m_ExecMode;
	CUtlString m_SpawnGroup;
	float32 m_PeriodicExecDelay;
	CommandEntitySpecType_t m_SpecType;
	CUtlString m_EntitySpec;
	CUtlString m_Commands;
	DebugOverlayBits_t m_SetDebugBits;
	DebugOverlayBits_t m_ClearDebugBits;
};
