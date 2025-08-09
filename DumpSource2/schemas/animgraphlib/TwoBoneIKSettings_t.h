// MGetKV3ClassDefaults = {
//	"m_endEffectorType": "IkEndEffector_Bone",
//	"m_endEffectorAttachment":
//	{
//		"m_influenceRotations":
//		[
//			[
//				0.000000,
//				0.000000,
//				0.000000,
//				0.000000
//			],
//			[
//				0.000000,
//				0.000000,
//				0.000000,
//				0.000000
//			],
//			[
//				0.000000,
//				0.000000,
//				0.000000,
//				0.000000
//			]
//		],
//		"m_influenceOffsets":
//		[
//			[
//				0.000000,
//				0.000000,
//				0.000000
//			],
//			[
//				0.000000,
//				0.000000,
//				0.000000
//			],
//			[
//				0.000000,
//				0.000000,
//				0.000000
//			]
//		],
//		"m_influenceIndices":
//		[
//			0,
//			0,
//			0
//		],
//		"m_influenceWeights":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		"m_numInfluences": 0
//	},
//	"m_targetType": "IkTarget_Bone",
//	"m_targetAttachment":
//	{
//		"m_influenceRotations":
//		[
//			[
//				0.000000,
//				0.000000,
//				0.000000,
//				0.000000
//			],
//			[
//				0.000000,
//				0.000000,
//				0.000000,
//				0.000000
//			],
//			[
//				0.000000,
//				0.000000,
//				0.000000,
//				0.000000
//			]
//		],
//		"m_influenceOffsets":
//		[
//			[
//				0.000000,
//				0.000000,
//				0.000000
//			],
//			[
//				0.000000,
//				0.000000,
//				0.000000
//			],
//			[
//				0.000000,
//				0.000000,
//				0.000000
//			]
//		],
//		"m_influenceIndices":
//		[
//			0,
//			0,
//			0
//		],
//		"m_influenceWeights":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		"m_numInfluences": 0
//	},
//	"m_targetBoneIndex": -1,
//	"m_hPositionParam":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hRotationParam":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_bAlwaysUseFallbackHinge": false,
//	"m_vLsFallbackHingeAxis":
//	[
//		0.000000,
//		1.000000,
//		0.000000
//	],
//	"m_nFixedBoneIndex": -1,
//	"m_nMiddleBoneIndex": -1,
//	"m_nEndBoneIndex": -1,
//	"m_bMatchTargetOrientation": false,
//	"m_bConstrainTwist": false,
//	"m_flMaxTwist": 15.000000
//}
class TwoBoneIKSettings_t
{
	IkEndEffectorType m_endEffectorType;
	CAnimAttachment m_endEffectorAttachment;
	IkTargetType m_targetType;
	CAnimAttachment m_targetAttachment;
	int32 m_targetBoneIndex;
	CAnimParamHandle m_hPositionParam;
	CAnimParamHandle m_hRotationParam;
	bool m_bAlwaysUseFallbackHinge;
	VectorAligned m_vLsFallbackHingeAxis;
	int32 m_nFixedBoneIndex;
	int32 m_nMiddleBoneIndex;
	int32 m_nEndBoneIndex;
	bool m_bMatchTargetOrientation;
	bool m_bConstrainTwist;
	float32 m_flMaxTwist;
};
