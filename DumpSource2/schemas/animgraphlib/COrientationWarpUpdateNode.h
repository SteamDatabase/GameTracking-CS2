// MGetKV3ClassDefaults = {
//	"_class": "COrientationWarpUpdateNode",
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
//	"m_eMode": "eInvalid",
//	"m_hTargetParam":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hTargetPositionParam":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hFallbackTargetPositionParam":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_eTargetOffsetMode": "eLiteralValue",
//	"m_flTargetOffset": 0.000000,
//	"m_hTargetOffsetParam":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_damping":
//	{
//		"_class": "CAnimInputDamping",
//		"m_speedFunction": "NoDamping",
//		"m_fSpeedScale": 1.000000,
//		"m_fFallingSpeedScale": 1.000000
//	},
//	"m_eRootMotionSource": "eAnimationOrProcedural",
//	"m_flMaxRootMotionScale": 10.000000,
//	"m_bEnablePreferredRotationDirection": false,
//	"m_ePreferredRotationDirection": "FacingHeading",
//	"m_flPreferredRotationThreshold": 190.000000
//}
class COrientationWarpUpdateNode : public CUnaryUpdateNode
{
	OrientationWarpMode_t m_eMode;
	CAnimParamHandle m_hTargetParam;
	CAnimParamHandle m_hTargetPositionParam;
	CAnimParamHandle m_hFallbackTargetPositionParam;
	OrientationWarpTargetOffsetMode_t m_eTargetOffsetMode;
	float32 m_flTargetOffset;
	CAnimParamHandle m_hTargetOffsetParam;
	CAnimInputDamping m_damping;
	OrientationWarpRootMotionSource_t m_eRootMotionSource;
	float32 m_flMaxRootMotionScale;
	bool m_bEnablePreferredRotationDirection;
	AnimValueSource m_ePreferredRotationDirection;
	float32 m_flPreferredRotationThreshold;
};
