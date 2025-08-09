// MGetKV3ClassDefaults = {
//	"_class": "CSelectorUpdateNode",
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
//	"m_children":
//	[
//	],
//	"m_tags":
//	[
//	],
//	"m_blendCurve":
//	{
//		"m_flControlPoint1": 0.000000,
//		"m_flControlPoint2": 1.000000
//	},
//	"m_flBlendTime":
//	{
//		"m_constValue": 0.000000,
//		"m_hParam":
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		}
//	},
//	"m_hParameter":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_nTagIndex": -1,
//	"m_eTagBehavior": "SelectorTagBehavior_OnWhileCurrent",
//	"m_bResetOnChange": false,
//	"m_bLockWhenWaning": false,
//	"m_bSyncCyclesOnChange": false
//}
class CSelectorUpdateNode : public CAnimUpdateNodeBase
{
	CUtlVector< CAnimUpdateNodeRef > m_children;
	CUtlVector< int8 > m_tags;
	CBlendCurve m_blendCurve;
	CAnimValue< float32 > m_flBlendTime;
	CAnimParamHandle m_hParameter;
	int32 m_nTagIndex;
	SelectorTagBehavior_t m_eTagBehavior;
	bool m_bResetOnChange;
	bool m_bLockWhenWaning;
	bool m_bSyncCyclesOnChange;
};
