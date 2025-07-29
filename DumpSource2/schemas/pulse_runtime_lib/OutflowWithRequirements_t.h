// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class OutflowWithRequirements_t
{
	CPulse_OutflowConnection m_Connection;
	PulseDocNodeID_t m_DestinationFlowNodeID;
	CUtlVector< PulseDocNodeID_t > m_RequirementNodeIDs;
	CUtlVector< int32 > m_nCursorStateBlockIndex;
};
