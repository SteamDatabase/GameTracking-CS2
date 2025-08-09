// MGetKV3ClassDefaults = {
//	"_class": "CFollowAttachmentUpdateNode",
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
//		"m_boneIndex": -1,
//		"m_attachmentHandle": 0,
//		"m_bMatchTranslation": false,
//		"m_bMatchRotation": false
//	}
//}
class CFollowAttachmentUpdateNode : public CUnaryUpdateNode
{
	FollowAttachmentSettings_t m_opFixedData;
};
