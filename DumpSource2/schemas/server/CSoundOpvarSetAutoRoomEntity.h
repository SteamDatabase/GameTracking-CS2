class CSoundOpvarSetAutoRoomEntity : public CSoundOpvarSetPointEntity
{
	CUtlVector< SoundOpvarTraceResult_t > m_traceResults;
	CUtlVector< AutoRoomDoorwayPairs_t > m_doorwayPairs;
	float32 m_flSize;
	float32 m_flHeightTolerance;
	float32 m_flSizeSqr;
};
