// MGetKV3ClassDefaults = {
//	"_class": "CNmStateNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nChildNodeIdx": -1,
//	"m_entryEvents":
//	[
//	],
//	"m_executeEvents":
//	[
//	],
//	"m_exitEvents":
//	[
//	],
//	"m_timedRemainingEvents":
//	[
//	],
//	"m_timedElapsedEvents":
//	[
//	],
//	"m_nLayerWeightNodeIdx": -1,
//	"m_nLayerRootMotionWeightNodeIdx": -1,
//	"m_nLayerBoneMaskNodeIdx": -1,
//	"m_bIsOffState": false,
//	"m_bUseActualElapsedTimeInStateForTimedEvents": false
//}
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
	bool m_bUseActualElapsedTimeInStateForTimedEvents;
};
