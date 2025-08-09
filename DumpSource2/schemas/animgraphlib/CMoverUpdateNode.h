// MGetKV3ClassDefaults = {
//	"_class": "CMoverUpdateNode",
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
//	"m_damping":
//	{
//		"_class": "CAnimInputDamping",
//		"m_speedFunction": "NoDamping",
//		"m_fSpeedScale": 1.000000,
//		"m_fFallingSpeedScale": 1.000000
//	},
//	"m_facingTarget": "MoveHeading",
//	"m_hMoveVecParam":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hMoveHeadingParam":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hTurnToFaceParam":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_flTurnToFaceOffset": 0.000000,
//	"m_flTurnToFaceLimit": 180.000000,
//	"m_bAdditive": false,
//	"m_bApplyMovement": false,
//	"m_bOrientMovement": false,
//	"m_bApplyRotation": false,
//	"m_bLimitOnly": false
//}
class CMoverUpdateNode : public CUnaryUpdateNode
{
	CAnimInputDamping m_damping;
	AnimValueSource m_facingTarget;
	CAnimParamHandle m_hMoveVecParam;
	CAnimParamHandle m_hMoveHeadingParam;
	CAnimParamHandle m_hTurnToFaceParam;
	float32 m_flTurnToFaceOffset;
	float32 m_flTurnToFaceLimit;
	bool m_bAdditive;
	bool m_bApplyMovement;
	bool m_bOrientMovement;
	bool m_bApplyRotation;
	bool m_bLimitOnly;
};
