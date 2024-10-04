class CPulseCell_Outflow_IntSwitch : public CPulseCell_BaseFlow
{
	CPulse_OutflowConnection m_DefaultCaseOutflow;
	CUtlVector< CPulse_OutflowConnection > m_CaseOutflows;
};
