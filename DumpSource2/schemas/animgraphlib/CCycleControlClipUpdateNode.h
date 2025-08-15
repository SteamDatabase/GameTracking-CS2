// MGetKV3ClassDefaults = {
//	"_class": "CCycleControlClipUpdateNode",
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
//	"m_tags":
//	[
//	],
//	"m_hSequence": -1,
//	"m_duration": 0.000000,
//	"m_valueSource": "MoveHeading",
//	"m_paramIndex":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_bLockWhenWaning": false
//}
class CCycleControlClipUpdateNode : public CLeafUpdateNode
{
	CUtlVector< TagSpan_t > m_tags;
	HSequence m_hSequence;
	float32 m_duration;
	AnimValueSource m_valueSource;
	CAnimParamHandle m_paramIndex;
	bool m_bLockWhenWaning;
};
