// MGetKV3ClassDefaults = {
//	"_class": "CFollowPathUpdateNode",
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
//	"m_flBlendOutTime": 0.300000,
//	"m_bBlockNonPathMovement": false,
//	"m_bStopFeetAtGoal": false,
//	"m_bScaleSpeed": false,
//	"m_flScale": 0.000000,
//	"m_flMinAngle": 0.000000,
//	"m_flMaxAngle": 0.000000,
//	"m_flSpeedScaleBlending": 0.000000,
//	"m_turnDamping":
//	{
//		"_class": "CAnimInputDamping",
//		"m_speedFunction": "NoDamping",
//		"m_fSpeedScale": 1.000000,
//		"m_fFallingSpeedScale": 1.000000
//	},
//	"m_facingTarget": "MoveHeading",
//	"m_hParam":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_flTurnToFaceOffset": 0.000000,
//	"m_bTurnToFace": false
//}
class CFollowPathUpdateNode : public CUnaryUpdateNode
{
	float32 m_flBlendOutTime;
	bool m_bBlockNonPathMovement;
	bool m_bStopFeetAtGoal;
	bool m_bScaleSpeed;
	float32 m_flScale;
	float32 m_flMinAngle;
	float32 m_flMaxAngle;
	float32 m_flSpeedScaleBlending;
	CAnimInputDamping m_turnDamping;
	AnimValueSource m_facingTarget;
	CAnimParamHandle m_hParam;
	float32 m_flTurnToFaceOffset;
	bool m_bTurnToFace;
};
