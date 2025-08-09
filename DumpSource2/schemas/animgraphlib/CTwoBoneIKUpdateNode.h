// MGetKV3ClassDefaults = {
//	"_class": "CTwoBoneIKUpdateNode",
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
//	"m_opFixedData":
//	{
//		"m_endEffectorType": "IkEndEffector_Bone",
//		"m_endEffectorAttachment":
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
//		"m_targetType": "IkTarget_Bone",
//		"m_targetAttachment":
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
//		"m_targetBoneIndex": -1,
//		"m_hPositionParam":
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		"m_hRotationParam":
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		"m_bAlwaysUseFallbackHinge": false,
//		"m_vLsFallbackHingeAxis":
//		[
//			0.000000,
//			1.000000,
//			0.000000
//		],
//		"m_nFixedBoneIndex": -1,
//		"m_nMiddleBoneIndex": -1,
//		"m_nEndBoneIndex": -1,
//		"m_bMatchTargetOrientation": false,
//		"m_bConstrainTwist": false,
//		"m_flMaxTwist": 15.000000
//	}
//}
class CTwoBoneIKUpdateNode : public CUnaryUpdateNode
{
	TwoBoneIKSettings_t m_opFixedData;
};
