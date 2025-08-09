// MGetKV3ClassDefaults = {
//	"_class": "CTargetWarpUpdateNode",
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
//	"m_pChildNode":
//	{
//		"m_nodeIndex": -1
//	},
//	"m_eAngleMode": "eFacingHeading",
//	"m_hTargetPositionParameter":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hTargetUpVectorParameter":
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
//	"m_eCorrectionMethod": "ScaleMotion",
//	"m_eTargetWarpTimingMethod": "ReachDestinationOnRootMotionEnd",
//	"m_bTargetFacePositionIsWorldSpace": false,
//	"m_bTargetPositionIsWorldSpace": false,
//	"m_bOnlyWarpWhenTagIsFound": false,
//	"m_bWarpOrientationDuringTranslation": false,
//	"m_bWarpAroundCenter": false,
//	"m_flMaxAngle": 180.000000
//}
class CTargetWarpUpdateNode : public CUnaryUpdateNode
{
	TargetWarpAngleMode_t m_eAngleMode;
	CAnimParamHandle m_hTargetPositionParameter;
	CAnimParamHandle m_hTargetUpVectorParameter;
	CAnimParamHandle m_hTargetFacePositionParameter;
	CAnimParamHandle m_hMoveHeadingParameter;
	CAnimParamHandle m_hDesiredMoveHeadingParameter;
	TargetWarpCorrectionMethod m_eCorrectionMethod;
	TargetWarpTimingMethod m_eTargetWarpTimingMethod;
	bool m_bTargetFacePositionIsWorldSpace;
	bool m_bTargetPositionIsWorldSpace;
	bool m_bOnlyWarpWhenTagIsFound;
	bool m_bWarpOrientationDuringTranslation;
	bool m_bWarpAroundCenter;
	float32 m_flMaxAngle;
};
