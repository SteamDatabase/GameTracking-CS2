// MGetKV3ClassDefaults = {
//	"_class": "CDirectPlaybackUpdateNode",
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
//	"m_bFinishEarly": false,
//	"m_bResetOnFinish": false,
//	"m_allTags":
//	[
//	]
//}
class CDirectPlaybackUpdateNode : public CUnaryUpdateNode
{
	bool m_bFinishEarly;
	bool m_bResetOnFinish;
	CUtlVector< CDirectPlaybackTagData > m_allTags;
};
