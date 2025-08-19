// MGetKV3ClassDefaults = {
//	"_class": "CLookAtUpdateNode",
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
//		"m_attachment":
//		{
//			"m_influenceRotations":
//			[
//				[
//					0.000000,
//					0.000000,
//					0.000000,
//					0.000000
//				],
//				[
//					0.000000,
//					0.000000,
//					0.000000,
//					0.000000
//				],
//				[
//					0.000000,
//					0.000000,
//					0.000000,
//					0.000000
//				]
//			],
//			"m_influenceOffsets":
//			[
//				[
//					0.000000,
//					0.000000,
//					0.000000
//				],
//				[
//					0.000000,
//					0.000000,
//					0.000000
//				],
//				[
//					0.000000,
//					0.000000,
//					0.000000
//				]
//			],
//			"m_influenceIndices":
//			[
//				0,
//				0,
//				0
//			],
//			"m_influenceWeights":
//			[
//				0.000000,
//				0.000000,
//				0.000000
//			],
//			"m_numInfluences": 0
//		},
//		"m_damping":
//		{
//			"_class": "CAnimInputDamping",
//			"m_speedFunction": "NoDamping",
//			"m_fSpeedScale": 1.000000,
//			"m_fFallingSpeedScale": 1.000000
//		},
//		"m_bones":
//		[
//		],
//		"m_flYawLimit": 45.000000,
//		"m_flPitchLimit": 45.000000,
//		"m_flHysteresisInnerAngle": 1.000000,
//		"m_flHysteresisOuterAngle": 20.000000,
//		"m_bRotateYawForward": true,
//		"m_bMaintainUpDirection": false,
//		"m_bTargetIsPosition": true,
//		"m_bUseHysteresis": false
//	},
//	"m_target": <HIDDEN FOR DIFF>,
//	"m_paramIndex":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_weightParamIndex":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_bResetChild": false,
//	"m_bLockWhenWaning": false
//}
class CLookAtUpdateNode : public CUnaryUpdateNode
{
	LookAtOpFixedSettings_t m_opFixedSettings;
	AnimVectorSource m_target;
	CAnimParamHandle m_paramIndex;
	CAnimParamHandle m_weightParamIndex;
	bool m_bResetChild;
	bool m_bLockWhenWaning;
};
