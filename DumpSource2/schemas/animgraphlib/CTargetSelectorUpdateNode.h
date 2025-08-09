// MGetKV3ClassDefaults = {
//	"_class": "CTargetSelectorUpdateNode",
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
//	"m_eAngleMode": "eFacingHeading",
//	"m_children":
//	[
//	],
//	"m_hTargetPosition":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hTargetFacePositionParameter":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hMoveHeadingParameter":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hDesiredMoveHeadingParameter":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_bTargetPositionIsWorldSpace": false,
//	"m_bTargetFacePositionIsWorldSpace": false,
//	"m_bEnablePhaseMatching": false,
//	"m_flPhaseMatchingMaxRootMotionSkip": 0.400000
//}
class CTargetSelectorUpdateNode : public CAnimUpdateNodeBase
{
	TargetSelectorAngleMode_t m_eAngleMode;
	CUtlVector< CAnimUpdateNodeRef > m_children;
	CAnimParamHandle m_hTargetPosition;
	CAnimParamHandle m_hTargetFacePositionParameter;
	CAnimParamHandle m_hMoveHeadingParameter;
	CAnimParamHandle m_hDesiredMoveHeadingParameter;
	bool m_bTargetPositionIsWorldSpace;
	bool m_bTargetFacePositionIsWorldSpace;
	bool m_bEnablePhaseMatching;
	float32 m_flPhaseMatchingMaxRootMotionSkip;
};
