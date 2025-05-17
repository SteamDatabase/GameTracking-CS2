// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CNmStateNode::CDefinition : public CNmPoseNode::CDefinition
{
	int16 m_nChildNodeIdx;
	CUtlLeanVectorFixedGrowable< CGlobalSymbol, 3 > m_entryEvents;
	CUtlLeanVectorFixedGrowable< CGlobalSymbol, 3 > m_executeEvents;
	CUtlLeanVectorFixedGrowable< CGlobalSymbol, 3 > m_exitEvents;
	CUtlLeanVectorFixedGrowable< CNmStateNode::TimedEvent_t, 1 > m_timedRemainingEvents;
	CUtlLeanVectorFixedGrowable< CNmStateNode::TimedEvent_t, 1 > m_timedElapsedEvents;
	int16 m_nLayerWeightNodeIdx;
	int16 m_nLayerRootMotionWeightNodeIdx;
	int16 m_nLayerBoneMaskNodeIdx;
	bool m_bIsOffState;
};
