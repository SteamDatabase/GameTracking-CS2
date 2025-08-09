// MGetKV3ClassDefaults = {
//	"_class": "CWayPointHelperUpdateNode",
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
//	"m_flStartCycle": 0.000000,
//	"m_flEndCycle": 0.000000,
//	"m_bOnlyGoals": true,
//	"m_bPreventOvershoot": true,
//	"m_bPreventUndershoot": false
//}
class CWayPointHelperUpdateNode : public CUnaryUpdateNode
{
	float32 m_flStartCycle;
	float32 m_flEndCycle;
	bool m_bOnlyGoals;
	bool m_bPreventOvershoot;
	bool m_bPreventUndershoot;
};
