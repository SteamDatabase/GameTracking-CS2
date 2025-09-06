// MGetKV3ClassDefaults = {
//	"m_attachment":
//	{
//		"m_influenceRotations": <HIDDEN FOR DIFF>,
//			[
//				-0.000000,
//				0.000000,
//				-0.000000,
//				0.000000
//			],
//			[
//				-0.000000,
//				0.000000,
//				-0.000000,
//				0.000000
//			]
//		],
//		"m_influenceOffsets": <HIDDEN FOR DIFF>,
//			[
//				0.000000,
//				0.000000,
//				-0.000000
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
//	"m_poseCacheHandles":
//	[
//		{
//			"m_nIndex": 65535,
//			"m_eType": "POSETYPE_INVALID"
//		},
//		{
//			"m_nIndex": 65535,
//			"m_eType": "POSETYPE_INVALID"
//		},
//		{
//			"m_nIndex": 65535,
//			"m_eType": "POSETYPE_INVALID"
//		},
//		{
//			"m_nIndex": 65535,
//			"m_eType": "POSETYPE_INVALID"
//		},
//		{
//			"m_nIndex": 65535,
//			"m_eType": "POSETYPE_INVALID"
//		},
//		{
//			"m_nIndex": 65535,
//			"m_eType": "POSETYPE_INVALID"
//		},
//		{
//			"m_nIndex": 65535,
//			"m_eType": "POSETYPE_INVALID"
//		},
//		{
//			"m_nIndex": 65535,
//			"m_eType": "POSETYPE_INVALID"
//		},
//		{
//			"m_nIndex": 65535,
//			"m_eType": "POSETYPE_INVALID"
//		},
//		{
//			"m_nIndex": 65535,
//			"m_eType": "POSETYPE_INVALID"
//		}
//	],
//	"m_eBlendMode": "AimMatrixBlendMode_None",
//	"m_flMaxYawAngle": 45.000000,
//	"m_flMaxPitchAngle": 45.000000,
//	"m_nSequenceMaxFrame": 0,
//	"m_nBoneMaskIndex": -1,
//	"m_bTargetIsPosition": true,
//	"m_bUseBiasAndClamp": false,
//	"m_flBiasAndClampYawOffset": 1.000000,
//	"m_flBiasAndClampPitchOffset": 1.000000,
//	"m_biasAndClampBlendCurve":
//	{
//		"m_flControlPoint1": 0.000000,
//		"m_flControlPoint2": 1.000000
//	}
//}
class AimMatrixOpFixedSettings_t
{
	CAnimAttachment m_attachment;
	CAnimInputDamping m_damping;
	CPoseHandle[10] m_poseCacheHandles;
	AimMatrixBlendMode m_eBlendMode;
	float32 m_flMaxYawAngle;
	float32 m_flMaxPitchAngle;
	int32 m_nSequenceMaxFrame;
	int32 m_nBoneMaskIndex;
	bool m_bTargetIsPosition;
	bool m_bUseBiasAndClamp;
	float32 m_flBiasAndClampYawOffset;
	float32 m_flBiasAndClampPitchOffset;
	CBlendCurve m_biasAndClampBlendCurve;
};
