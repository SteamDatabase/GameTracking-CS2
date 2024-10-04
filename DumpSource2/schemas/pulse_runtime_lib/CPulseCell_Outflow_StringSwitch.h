class CPulseCell_Outflow_StringSwitch : public CPulseCell_BaseFlow
{
	CPulse_OutflowConnection m_DefaultCaseOutflow;
	CUtlVector< CPulse_OutflowConnection > m_CaseOutflows;
}
