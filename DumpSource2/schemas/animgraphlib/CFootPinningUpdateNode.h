// MGetKV3ClassDefaults = {
//	"_class": "CFootPinningUpdateNode",
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
//	"m_poseOpFixedData":
//	{
//		"m_footInfo":
//		[
//		],
//		"m_flBlendTime": 0.000000,
//		"m_flLockBreakDistance": 0.000000,
//		"m_flMaxLegTwist": 25.000000,
//		"m_nHipBoneIndex": -1,
//		"m_bApplyLegTwistLimits": false,
//		"m_bApplyFootRotationLimits": false
//	},
//	"m_eTimingSource": "FootMotion",
//	"m_params":
//	[
//	],
//	"m_bResetChild": false
//}
class CFootPinningUpdateNode : public CUnaryUpdateNode
{
	FootPinningPoseOpFixedData_t m_poseOpFixedData;
	FootPinningTimingSource m_eTimingSource;
	CUtlVector< CAnimParamHandle > m_params;
	bool m_bResetChild;
};
