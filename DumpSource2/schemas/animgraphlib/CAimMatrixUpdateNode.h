// MGetKV3ClassDefaults = {
//	"_class": "CAimMatrixUpdateNode",
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
//		"m_poseCacheHandles":
//		[
//			{
//				"m_nIndex": 65535,
//				"m_eType": "POSETYPE_INVALID"
//			},
//			{
//				"m_nIndex": 65535,
//				"m_eType": "POSETYPE_INVALID"
//			},
//			{
//				"m_nIndex": 65535,
//				"m_eType": "POSETYPE_INVALID"
//			},
//			{
//				"m_nIndex": 65535,
//				"m_eType": "POSETYPE_INVALID"
//			},
//			{
//				"m_nIndex": 65535,
//				"m_eType": "POSETYPE_INVALID"
//			},
//			{
//				"m_nIndex": 65535,
//				"m_eType": "POSETYPE_INVALID"
//			},
//			{
//				"m_nIndex": 65535,
//				"m_eType": "POSETYPE_INVALID"
//			},
//			{
//				"m_nIndex": 65535,
//				"m_eType": "POSETYPE_INVALID"
//			},
//			{
//				"m_nIndex": 65535,
//				"m_eType": "POSETYPE_INVALID"
//			},
//			{
//				"m_nIndex": 65535,
//				"m_eType": "POSETYPE_INVALID"
//			}
//		],
//		"m_eBlendMode": "AimMatrixBlendMode_None",
//		"m_flMaxYawAngle": 45.000000,
//		"m_flMaxPitchAngle": 45.000000,
//		"m_nSequenceMaxFrame": 0,
//		"m_nBoneMaskIndex": -1,
//		"m_bTargetIsPosition": true,
//		"m_bUseBiasAndClamp": false,
//		"m_flBiasAndClampYawOffset": 1.000000,
//		"m_flBiasAndClampPitchOffset": 1.000000,
//		"m_biasAndClampBlendCurve":
//		{
//			"m_flControlPoint1": 0.000000,
//			"m_flControlPoint2": 1.000000
//		}
//	},
//	"m_target": -232,
//	"m_paramIndex":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hSequence": -1,
//	"m_bResetChild": false,
//	"m_bLockWhenWaning": false
//}
class CAimMatrixUpdateNode : public CUnaryUpdateNode
{
	AimMatrixOpFixedSettings_t m_opFixedSettings;
	AnimVectorSource m_target;
	CAnimParamHandle m_paramIndex;
	HSequence m_hSequence;
	bool m_bResetChild;
	bool m_bLockWhenWaning;
};
