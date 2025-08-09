// MGetKV3ClassDefaults = {
//	"_class": "CBlendUpdateNode",
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
//	"m_children":
//	[
//	],
//	"m_sortedOrder":
//	[
//	],
//	"m_targetValues":
//	[
//	],
//	"m_blendValueSource": "MoveHeading",
//	"m_eLinearRootMotionBlendMode": "LERP",
//	"m_paramIndex":
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
//	"m_blendKeyType": "BlendKey_UserValue",
//	"m_bLockBlendOnReset": false,
//	"m_bSyncCycles": false,
//	"m_bLoop": false,
//	"m_bLockWhenWaning": false,
//	"m_bIsAngle": false
//}
class CBlendUpdateNode : public CAnimUpdateNodeBase
{
	CUtlVector< CAnimUpdateNodeRef > m_children;
	CUtlVector< uint8 > m_sortedOrder;
	CUtlVector< float32 > m_targetValues;
	AnimValueSource m_blendValueSource;
	LinearRootMotionBlendMode_t m_eLinearRootMotionBlendMode;
	CAnimParamHandle m_paramIndex;
	CAnimInputDamping m_damping;
	BlendKeyType m_blendKeyType;
	bool m_bLockBlendOnReset;
	bool m_bSyncCycles;
	bool m_bLoop;
	bool m_bLockWhenWaning;
	bool m_bIsAngle;
};
