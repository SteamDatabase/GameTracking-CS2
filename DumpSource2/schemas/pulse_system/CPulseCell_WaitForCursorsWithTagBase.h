class CPulseCell_WaitForCursorsWithTagBase : public CPulseCell_BaseYieldingInflow
{
	int32 m_nCursorsAllowedToWait;
	CPulse_ResumePoint m_WaitComplete;
};
