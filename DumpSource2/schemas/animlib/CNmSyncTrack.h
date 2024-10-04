class CNmSyncTrack
{
	CUtlLeanVectorFixedGrowable< CNmSyncTrack::Event_t, 10 > m_syncEvents;
	int32 m_nStartEventOffset;
};
