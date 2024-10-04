class CPulseCell_Timeline : public CPulseCell_BaseYieldingInflow
{
	CUtlVector< CPulseCell_Timeline::TimelineEvent_t > m_TimelineEvents;
	bool m_bWaitForChildOutflows;
	CPulse_ResumePoint m_OnFinished;
	CPulse_ResumePoint m_OnCanceled;
};
