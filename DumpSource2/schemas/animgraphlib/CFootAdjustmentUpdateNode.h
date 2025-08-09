// MGetKV3ClassDefaults = {
//	"_class": "CFootAdjustmentUpdateNode",
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
//	"m_clips":
//	[
//	],
//	"m_hBasePoseCacheHandle":
//	{
//		"m_nIndex": 65535,
//		"m_eType": "POSETYPE_INVALID"
//	},
//	"m_facingTarget":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_flTurnTimeMin": 0.000000,
//	"m_flTurnTimeMax": 0.000000,
//	"m_flStepHeightMax": 0.000000,
//	"m_flStepHeightMaxAngle": 0.000000,
//	"m_bResetChild": false,
//	"m_bAnimationDriven": false
//}
class CFootAdjustmentUpdateNode : public CUnaryUpdateNode
{
	CUtlVector< HSequence > m_clips;
	CPoseHandle m_hBasePoseCacheHandle;
	CAnimParamHandle m_facingTarget;
	float32 m_flTurnTimeMin;
	float32 m_flTurnTimeMax;
	float32 m_flStepHeightMax;
	float32 m_flStepHeightMaxAngle;
	bool m_bResetChild;
	bool m_bAnimationDriven;
};
