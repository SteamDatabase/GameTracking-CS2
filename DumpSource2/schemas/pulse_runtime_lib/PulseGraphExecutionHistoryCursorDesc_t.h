// MGetKV3ClassDefaults = {
//	"vecAncestorCursorIDs":
//	[
//	],
//	"nSpawnNodeID": -1,
//	"nRetiredAtNodeID": -1,
//	"flLastReferenced": 0.000000,
//	"nLastValidEntryIdx": 0
//}
class PulseGraphExecutionHistoryCursorDesc_t
{
	CUtlVector< PulseCursorID_t > vecAncestorCursorIDs;
	PulseDocNodeID_t nSpawnNodeID;
	PulseDocNodeID_t nRetiredAtNodeID;
	float32 flLastReferenced;
	int32 nLastValidEntryIdx;
};
