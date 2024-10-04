class CPulseCell_Outflow_ListenForEntityOutput : public CPulseCell_BaseYieldingInflow
{
	SignatureOutflow_Resume m_OnFired;
	CPulse_ResumePoint m_OnCanceled;
	CGlobalSymbol m_strEntityOutput;
	CUtlString m_strEntityOutputParam;
	bool m_bListenUntilCanceled;
}
