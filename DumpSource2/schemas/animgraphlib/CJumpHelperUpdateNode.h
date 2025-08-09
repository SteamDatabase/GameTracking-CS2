// MGetKV3ClassDefaults = {
//	"_class": "CJumpHelperUpdateNode",
//	"m_nodePath":
//	{
//		"m_path":
//		[
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			}
//		],
//		"m_nCount": 0
//	},
//	"m_networkMode": "ServerAuthoritative",
//	"m_name": "",
//	"m_playbackSpeed": 1.000000,
//	"m_bLoop": false,
//	"m_hSequence": -1,
//	"m_duration": 0.000000,
//	"m_paramSpans":
//	{
//		"m_spans":
//		[
//		]
//	},
//	"m_tags":
//	[
//	],
//	"m_hTargetParam":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_flOriginalJumpMovement":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_flOriginalJumpDuration": 0.000000,
//	"m_flJumpStartCycle": 0.000000,
//	"m_flJumpEndCycle": 0.000000,
//	"m_eCorrectionMethod": "ScaleMotion",
//	"m_bTranslationAxis":
//	[
//		false,
//		false,
//		false
//	],
//	"m_bScaleSpeed": false
//}
class CJumpHelperUpdateNode : public CSequenceUpdateNode
{
	CAnimParamHandle m_hTargetParam;
	Vector m_flOriginalJumpMovement;
	float32 m_flOriginalJumpDuration;
	float32 m_flJumpStartCycle;
	float32 m_flJumpEndCycle;
	JumpCorrectionMethod m_eCorrectionMethod;
	bool[3] m_bTranslationAxis;
	bool m_bScaleSpeed;
};
