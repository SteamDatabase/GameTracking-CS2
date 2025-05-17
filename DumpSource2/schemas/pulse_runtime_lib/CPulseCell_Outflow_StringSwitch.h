// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MCellForDomain = "BaseDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
// MPulseCellWithCustomDocNode
class CPulseCell_Outflow_StringSwitch : public CPulseCell_BaseFlow
{
	CPulse_OutflowConnection m_DefaultCaseOutflow;
	CUtlVector< CPulse_OutflowConnection > m_CaseOutflows;
};
