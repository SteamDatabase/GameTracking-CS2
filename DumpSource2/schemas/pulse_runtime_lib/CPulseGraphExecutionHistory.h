// MGetKV3ClassDefaults = {
//	"m_nInstanceID": 0,
//	"m_strFileName": "",
//	"m_vecHistory":
//	[
//	],
//	"m_mapCellDesc":
//	{
//	},
//	"m_mapCursorDesc":
//	{
//	}
//}
class CPulseGraphExecutionHistory
{
	PulseGraphInstanceID_t m_nInstanceID;
	CUtlString m_strFileName;
	CUtlVector< PulseGraphExecutionHistoryEntry_t* > m_vecHistory;
	CUtlOrderedMap< PulseDocNodeID_t, PulseGraphExecutionHistoryNodeDesc_t* > m_mapCellDesc;
	CUtlOrderedMap< PulseCursorID_t, PulseGraphExecutionHistoryCursorDesc_t* > m_mapCursorDesc;
};
