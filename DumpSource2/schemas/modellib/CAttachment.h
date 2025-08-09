// MGetKV3ClassDefaults = {
//	"m_name": "",
//	"m_influenceNames":
//	[
//		"",
//		"",
//		""
//	],
//	"m_vInfluenceRotations":
//	[
//		[
//			0.000000,
//			0.000000,
//			0.000000,
//			1.000000
//		],
//		[
//			0.000000,
//			0.000000,
//			0.000000,
//			1.000000
//		],
//		[
//			0.000000,
//			0.000000,
//			0.000000,
//			1.000000
//		]
//	],
//	"m_vInfluenceOffsets":
//	[
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		]
//	],
//	"m_influenceWeights":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_bInfluenceRootTransform":
//	[
//		false,
//		false,
//		false
//	],
//	"m_nInfluences": 0,
//	"m_bIgnoreRotation": false
//}
class CAttachment
{
	CUtlString m_name;
	CUtlString[3] m_influenceNames;
	Quaternion[3] m_vInfluenceRotations;
	Vector[3] m_vInfluenceOffsets;
	float32[3] m_influenceWeights;
	bool[3] m_bInfluenceRootTransform;
	uint8 m_nInfluences;
	bool m_bIgnoreRotation;
};
