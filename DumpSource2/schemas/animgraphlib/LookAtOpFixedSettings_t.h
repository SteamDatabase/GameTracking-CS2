// MGetKV3ClassDefaults = {
//	"m_attachment":
//	{
//		"m_influenceRotations": <HIDDEN FOR DIFF>,
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
//	"m_damping":
//	{
//		"_class": "CAnimInputDamping",
//		"m_speedFunction": "NoDamping",
//		"m_fSpeedScale": 1.000000,
//		"m_fFallingSpeedScale": 1.000000
//	},
//	"m_bones":
//	[
//	],
//	"m_flYawLimit": 45.000000,
//	"m_flPitchLimit": 45.000000,
//	"m_flHysteresisInnerAngle": 1.000000,
//	"m_flHysteresisOuterAngle": 20.000000,
//	"m_bRotateYawForward": true,
//	"m_bMaintainUpDirection": false,
//	"m_bTargetIsPosition": true,
//	"m_bUseHysteresis": false
//}
class LookAtOpFixedSettings_t
{
	CAnimAttachment m_attachment;
	CAnimInputDamping m_damping;
	CUtlVector< LookAtBone_t > m_bones;
	float32 m_flYawLimit;
	float32 m_flPitchLimit;
	float32 m_flHysteresisInnerAngle;
	float32 m_flHysteresisOuterAngle;
	bool m_bRotateYawForward;
	bool m_bMaintainUpDirection;
	bool m_bTargetIsPosition;
	bool m_bUseHysteresis;
};
