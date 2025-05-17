// MNetworkVarNames = "float m_flValues"
// MNetworkVarNames = "int m_nValueCounts"
// MNetworkVarNames = "int m_nBucketCount"
// MNetworkVarNames = "float m_flInterval"
// MNetworkVarNames = "float m_flFinalValue"
// MNetworkVarNames = "TimelineCompression_t m_nCompressionType"
// MNetworkVarNames = "bool m_bStopped"
class CTimeline : public IntervalTimer
{
	// MNetworkEnable
	float32[64] m_flValues;
	// MNetworkEnable
	int32[64] m_nValueCounts;
	// MNetworkEnable
	int32 m_nBucketCount;
	// MNetworkEnable
	float32 m_flInterval;
	// MNetworkEnable
	float32 m_flFinalValue;
	// MNetworkEnable
	TimelineCompression_t m_nCompressionType;
	// MNetworkEnable
	bool m_bStopped;
};
