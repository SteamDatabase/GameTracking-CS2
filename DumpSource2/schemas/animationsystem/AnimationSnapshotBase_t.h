// MGetKV3ClassDefaults = {
//	"m_flRealTime": 0.000000,
//	"m_rootToWorld":
//	[
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_bBonesInWorldSpace": false,
//	"m_boneSetupMask":
//	[
//	],
//	"m_boneTransforms":
//	[
//	],
//	"m_flexControllers":
//	[
//	],
//	"m_SnapshotType": "ANIMATION_SNAPSHOT_SERVER_SIMULATION",
//	"m_bHasDecodeDump": false,
//	"m_DecodeDump":
//	{
//		"m_nEntityIndex": 0,
//		"m_modelName": "",
//		"m_poseParams":
//		[
//		],
//		"m_decodeOps":
//		[
//		],
//		"m_internalOps":
//		[
//		],
//		"m_decodedAnims":
//		[
//		]
//	}
//}
class AnimationSnapshotBase_t
{
	float32 m_flRealTime;
	matrix3x4a_t m_rootToWorld;
	bool m_bBonesInWorldSpace;
	CUtlVector< uint32 > m_boneSetupMask;
	CUtlVector< matrix3x4a_t > m_boneTransforms;
	CUtlVector< float32 > m_flexControllers;
	AnimationSnapshotType_t m_SnapshotType;
	bool m_bHasDecodeDump;
	AnimationDecodeDebugDumpElement_t m_DecodeDump;
};
