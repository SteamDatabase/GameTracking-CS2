// MGetKV3ClassDefaults = {
//	"_class": "CLeanMatrixUpdateNode",
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
//	"m_frameCorners": <HIDDEN FOR DIFF>,
//		[
//			0,
//			0,
//			0
//		],
//		[
//			0,
//			0,
//			0
//		]
//	],
//	"m_poses":
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
//		}
//	],
//	"m_damping":
//	{
//		"_class": "CAnimInputDamping",
//		"m_speedFunction": "NoDamping",
//		"m_fSpeedScale": 1.000000,
//		"m_fFallingSpeedScale": 1.000000
//	},
//	"m_blendSource": "MoveDirection",
//	"m_paramIndex":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_verticalAxis":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_horizontalAxis":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_hSequence": -1,
//	"m_flMaxValue": 0.000000,
//	"m_nSequenceMaxFrame": 0
//}
class CLeanMatrixUpdateNode : public CLeafUpdateNode
{
	int32[3][3] m_frameCorners;
	CPoseHandle[9] m_poses;
	CAnimInputDamping m_damping;
	AnimVectorSource m_blendSource;
	CAnimParamHandle m_paramIndex;
	Vector m_verticalAxis;
	Vector m_horizontalAxis;
	HSequence m_hSequence;
	float32 m_flMaxValue;
	int32 m_nSequenceMaxFrame;
};
