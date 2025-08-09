// MGetKV3ClassDefaults = {
//	"_class": "CSubtractUpdateNode",
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
//	"m_footMotionTiming": "Child1",
//	"m_bApplyToFootMotion": true,
//	"m_bApplyChannelsSeparately": true,
//	"m_bUseModelSpace": false
//}
class CSubtractUpdateNode : public CBinaryUpdateNode
{
	BinaryNodeChildOption m_footMotionTiming;
	bool m_bApplyToFootMotion;
	bool m_bApplyChannelsSeparately;
	bool m_bUseModelSpace;
};
