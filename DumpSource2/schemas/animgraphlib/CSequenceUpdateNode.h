// MGetKV3ClassDefaults = {
//	"_class": "CSequenceUpdateNode",
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
//	]
//}
class CSequenceUpdateNode : public CSequenceUpdateNodeBase
{
	HSequence m_hSequence;
	float32 m_duration;
	CParamSpanUpdater m_paramSpans;
	CUtlVector< TagSpan_t > m_tags;
};
