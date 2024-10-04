class CPulseCell_Timeline::TimelineEvent_t
{
	float32 m_flTimeFromPrevious;
	bool m_bPauseForPreviousEvents;
	bool m_bCallModeSync;
	CPulse_OutflowConnection m_EventOutflow;
};
