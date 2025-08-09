// MGetKV3ClassDefaults = {
//	"_class": "CStopAtGoalUpdateNode",
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
//	"m_flOuterRadius": 0.000000,
//	"m_flInnerRadius": 0.000000,
//	"m_flMaxScale": 0.000000,
//	"m_flMinScale": 0.000000,
//	"m_damping":
//	{
//		"_class": "CAnimInputDamping",
//		"m_speedFunction": "NoDamping",
//		"m_fSpeedScale": 1.000000,
//		"m_fFallingSpeedScale": 1.000000
//	}
//}
class CStopAtGoalUpdateNode : public CUnaryUpdateNode
{
	float32 m_flOuterRadius;
	float32 m_flInnerRadius;
	float32 m_flMaxScale;
	float32 m_flMinScale;
	CAnimInputDamping m_damping;
};
