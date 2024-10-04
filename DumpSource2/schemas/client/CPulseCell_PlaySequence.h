class CPulseCell_PlaySequence : public CPulseCell_BaseYieldingInflow
{
	CUtlString m_SequenceName;
	PulseNodeDynamicOutflows_t m_PulseAnimEvents;
	CPulse_ResumePoint m_OnFinished;
	CPulse_ResumePoint m_OnCanceled;
}
