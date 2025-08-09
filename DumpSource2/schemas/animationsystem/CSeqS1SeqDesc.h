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
//	"m_fetch":
//	{
//		"m_flags":
//		{
//			"m_bRealtime": false,
//			"m_bCylepose": false,
//			"m_b0D": false,
//			"m_b1D": false,
//			"m_b2D": false,
//			"m_b2D_TRI": false
//		},
//		"m_localReferenceArray":
//		[
//		],
//		"m_nGroupSize":
//		[
//			0,
//			0
//		],
//		"m_nLocalPose":
//		[
//			0,
//			0
//		],
//		"m_poseKeyArray0":
//		[
//		],
//		"m_poseKeyArray1":
//		[
//		],
//		"m_nLocalCyclePoseParameter": 0,
//		"m_bCalculatePoseParameters": false,
//		"m_bFixedBlendWeight": false,
//		"m_flFixedBlendWeightVals":
//		[
//			0.000000,
//			0.000000
//		]
//	},
//	"m_nLocalWeightlist": 0,
//	"m_autoLayerArray":
//	[
//	],
//	"m_IKLockArray":
//	[
//	],
//	"m_transition":
//	{
//		"m_flFadeInTime": 0.000000,
//		"m_flFadeOutTime": 0.000000
//	},
//	"m_SequenceKeys": null,
//	"m_keyValueText": "",
//	"m_activityArray":
//	[
//	],
//	"m_footMotion":
//	[
//	]
//}
class CSeqS1SeqDesc
{
	CBufferString m_sName;
	CSeqSeqDescFlag m_flags;
	CSeqMultiFetch m_fetch;
	int32 m_nLocalWeightlist;
	CUtlVector< CSeqAutoLayer > m_autoLayerArray;
	CUtlVector< CSeqIKLock > m_IKLockArray;
	CSeqTransition m_transition;
	KeyValues3 m_SequenceKeys;
	// MKV3TransferName = "m_keyValueText"
	CBufferString m_LegacyKeyValueText;
	CUtlVector< CAnimActivity > m_activityArray;
	CUtlVector< CFootMotion > m_footMotion;
};
