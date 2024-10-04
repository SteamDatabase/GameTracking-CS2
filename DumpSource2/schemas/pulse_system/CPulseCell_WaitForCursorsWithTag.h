class CPulseCell_WaitForCursorsWithTag : public CPulseCell_WaitForCursorsWithTagBase
{
	bool m_bTagSelfWhenComplete;
	PulseCursorCancelPriority_t m_nDesiredKillPriority;
};
