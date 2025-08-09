// MGetKV3ClassDefaults = {
//	"_class": "CTurnHelperUpdateNode",
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
//	"m_facingTarget": "MoveHeading",
//	"m_turnStartTimeOffset": 0.000000,
//	"m_turnDuration": 1.000000,
//	"m_bMatchChildDuration": true,
//	"m_manualTurnOffset": 0.000000,
//	"m_bUseManualTurnOffset": false
//}
class CTurnHelperUpdateNode : public CUnaryUpdateNode
{
	AnimValueSource m_facingTarget;
	float32 m_turnStartTimeOffset;
	float32 m_turnDuration;
	bool m_bMatchChildDuration;
	float32 m_manualTurnOffset;
	bool m_bUseManualTurnOffset;
};
