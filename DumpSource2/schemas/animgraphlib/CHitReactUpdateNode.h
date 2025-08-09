// MGetKV3ClassDefaults = {
//	"_class": "CHitReactUpdateNode",
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
//	"m_opFixedSettings":
//	{
//		"m_nWeightListIndex": 0,
//		"m_nEffectedBoneCount": 0,
//		"m_flMaxImpactForce": 0.000000,
//		"m_flMinImpactForce": 0.000000,
//		"m_flWhipImpactScale": 0.000000,
//		"m_flCounterRotationScale": 0.000000,
//		"m_flDistanceFadeScale": 0.000000,
//		"m_flPropagationScale": 0.000000,
//		"m_flWhipDelay": 0.000000,
//		"m_flSpringStrength": 0.000000,
//		"m_flWhipSpringStrength": 0.000000,
//		"m_flMaxAngleRadians": 0.000000,
//		"m_nHipBoneIndex": 0,
//		"m_flHipBoneTranslationScale": 0.000000,
//		"m_flHipDipSpringStrength": 0.000000,
//		"m_flHipDipImpactScale": 0.000000,
//		"m_flHipDipDelay": 0.000000
//	},
//	"m_triggerParam":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hitBoneParam":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hitOffsetParam":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hitDirectionParam":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hitStrengthParam":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_flMinDelayBetweenHits": 0.000000,
//	"m_bResetChild": false
//}
class CHitReactUpdateNode : public CUnaryUpdateNode
{
	HitReactFixedSettings_t m_opFixedSettings;
	CAnimParamHandle m_triggerParam;
	CAnimParamHandle m_hitBoneParam;
	CAnimParamHandle m_hitOffsetParam;
	CAnimParamHandle m_hitDirectionParam;
	CAnimParamHandle m_hitStrengthParam;
	float32 m_flMinDelayBetweenHits;
	bool m_bResetChild;
};
