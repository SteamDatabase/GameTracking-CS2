class PulseGraphExecutionHistoryCursorDesc_t
{
	CUtlVector< PulseCursorID_t > vecAncestorCursorIDs;
	PulseDocNodeID_t nSpawnNodeID;
	PulseDocNodeID_t nRetiredAtNodeID;
	float32 flLastReferenced;
	int32 nLastValidEntryIdx;
}
