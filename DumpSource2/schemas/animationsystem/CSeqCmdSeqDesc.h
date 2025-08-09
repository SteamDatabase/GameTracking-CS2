// MGetKV3ClassDefaults = {
//	"m_sName": "",
//	"m_flags":
//	{
//		"m_bLooping": false,
//		"m_bSnap": false,
//		"m_bAutoplay": false,
//		"m_bPost": false,
//		"m_bHidden": false,
//		"m_bMulti": false,
//		"m_bLegacyDelta": false,
//		"m_bLegacyWorldspace": false,
//		"m_bLegacyCyclepose": false,
//		"m_bLegacyRealtime": false,
//		"m_bModelDoc": false
//	},
//	"m_transition":
//	{
//		"m_flFadeInTime": 0.000000,
//		"m_flFadeOutTime": 0.000000
//	},
//	"m_nFrameRangeSequence": 0,
//	"m_nFrameCount": 0,
//	"m_flFPS": 30.000000,
//	"m_nSubCycles": 1,
//	"m_numLocalResults": 0,
//	"m_cmdLayerArray":
//	[
//	],
//	"m_eventArray":
//	[
//	],
//	"m_activityArray":
//	[
//	],
//	"m_poseSettingArray":
//	[
//	]
//}
class CSeqCmdSeqDesc
{
	CBufferString m_sName;
	CSeqSeqDescFlag m_flags;
	CSeqTransition m_transition;
	int16 m_nFrameRangeSequence;
	int16 m_nFrameCount;
	float32 m_flFPS;
	int16 m_nSubCycles;
	int16 m_numLocalResults;
	CUtlVector< CSeqCmdLayer > m_cmdLayerArray;
	CUtlVector< CAnimEventDefinition > m_eventArray;
	CUtlVector< CAnimActivity > m_activityArray;
	CUtlVector< CSeqPoseSetting > m_poseSettingArray;
};
