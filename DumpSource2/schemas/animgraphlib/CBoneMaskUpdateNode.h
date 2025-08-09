// MGetKV3ClassDefaults = {
//	"_class": "CBoneMaskUpdateNode",
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
//	"m_pChild1":
//	{
//		"m_nodeIndex": -1
//	},
//	"m_pChild2":
//	{
//		"m_nodeIndex": -1
//	},
//	"m_timingBehavior": "UseChild1",
//	"m_flTimingBlend": 0.500000,
//	"m_bResetChild1": true,
//	"m_bResetChild2": true,
//	"m_nWeightListIndex": 0,
//	"m_flRootMotionBlend": 0.000000,
//	"m_blendSpace": "BlendSpace_Parent",
//	"m_footMotionTiming": "Child1",
//	"m_bUseBlendScale": false,
//	"m_blendValueSource": "MoveHeading",
//	"m_hBlendParameter":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	}
//}
class CBoneMaskUpdateNode : public CBinaryUpdateNode
{
	int32 m_nWeightListIndex;
	float32 m_flRootMotionBlend;
	BoneMaskBlendSpace m_blendSpace;
	BinaryNodeChildOption m_footMotionTiming;
	bool m_bUseBlendScale;
	AnimValueSource m_blendValueSource;
	CAnimParamHandle m_hBlendParameter;
};
