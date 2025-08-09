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
//	"m_nLocalBaseReference": 0,
//	"m_nLocalBoneMask": 0,
//	"m_activityArray":
//	[
//	]
//}
class CSeqSynthAnimDesc
{
	CBufferString m_sName;
	CSeqSeqDescFlag m_flags;
	CSeqTransition m_transition;
	int16 m_nLocalBaseReference;
	int16 m_nLocalBoneMask;
	CUtlVector< CAnimActivity > m_activityArray;
};
