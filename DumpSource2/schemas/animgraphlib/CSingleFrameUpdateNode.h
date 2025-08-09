// MGetKV3ClassDefaults = {
//	"_class": "CSingleFrameUpdateNode",
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
//	"m_actions":
//	[
//	],
//	"m_hPoseCacheHandle":
//	{
//		"m_nIndex": 65535,
//		"m_eType": "POSETYPE_INVALID"
//	},
//	"m_hSequence": -1,
//	"m_flCycle": 0.000000
//}
class CSingleFrameUpdateNode : public CLeafUpdateNode
{
	CUtlVector< CSmartPtr< CAnimActionUpdater > > m_actions;
	CPoseHandle m_hPoseCacheHandle;
	HSequence m_hSequence;
	float32 m_flCycle;
};
