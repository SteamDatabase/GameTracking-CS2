// MGetKV3ClassDefaults = {
//	"_class": "CBlend2DUpdateNode",
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
//	"m_items":
//	[
//	],
//	"m_tags":
//	[
//	],
//	"m_paramSpans":
//	{
//		"m_spans":
//		[
//		]
//	},
//	"m_nodeItemIndices":
//	[
//	],
//	"m_damping":
//	{
//		"_class": "CAnimInputDamping",
//		"m_speedFunction": "NoDamping",
//		"m_fSpeedScale": 1.000000,
//		"m_fFallingSpeedScale": 1.000000
//	},
//	"m_blendSourceX": "MoveHeading",
//	"m_paramX":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_blendSourceY": "MoveHeading",
//	"m_paramY":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_eBlendMode": "Blend2DMode_General",
//	"m_playbackSpeed": 0.000000,
//	"m_bLoop": false,
//	"m_bLockBlendOnReset": false,
//	"m_bLockWhenWaning": false,
//	"m_bAnimEventsAndTagsOnMostWeightedOnly": false
//}
class CBlend2DUpdateNode : public CAnimUpdateNodeBase
{
	CUtlVector< BlendItem_t > m_items;
	CUtlVector< TagSpan_t > m_tags;
	CParamSpanUpdater m_paramSpans;
	CUtlVector< int32 > m_nodeItemIndices;
	CAnimInputDamping m_damping;
	AnimValueSource m_blendSourceX;
	CAnimParamHandle m_paramX;
	AnimValueSource m_blendSourceY;
	CAnimParamHandle m_paramY;
	Blend2DMode m_eBlendMode;
	float32 m_playbackSpeed;
	bool m_bLoop;
	bool m_bLockBlendOnReset;
	bool m_bLockWhenWaning;
	bool m_bAnimEventsAndTagsOnMostWeightedOnly;
};
