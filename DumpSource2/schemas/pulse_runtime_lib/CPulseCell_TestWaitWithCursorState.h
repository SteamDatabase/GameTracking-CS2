class CPulseCell_TestWaitWithCursorState : public CPulseCell_BaseYieldingInflow
{
	CPulse_ResumePoint m_WakeResume;
	CPulse_ResumePoint m_WakeCancel;
	CPulse_ResumePoint m_WakeFail;
};
