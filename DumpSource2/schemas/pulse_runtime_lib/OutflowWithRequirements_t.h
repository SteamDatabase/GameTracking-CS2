// MGetKV3ClassDefaults = {
//	"m_Connection":
//	{
//		"m_SourceOutflowName": "",
//		"m_nDestChunk": -1,
//		"m_nInstruction": -1
//	},
//	"m_DestinationFlowNodeID": -1,
//	"m_RequirementNodeIDs":
//	[
//	],
//	"m_nCursorStateBlockIndex":
//	[
//	]
//}
class OutflowWithRequirements_t
{
	CPulse_OutflowConnection m_Connection;
	PulseDocNodeID_t m_DestinationFlowNodeID;
	CUtlVector< PulseDocNodeID_t > m_RequirementNodeIDs;
	CUtlVector< int32 > m_nCursorStateBlockIndex;
};
