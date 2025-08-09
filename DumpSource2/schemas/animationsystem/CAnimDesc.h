// MGetKV3ClassDefaults = {
//	"m_name": "",
//	"m_flags":
//	{
//		"m_bLooping": false,
//		"m_bAllZeros": false,
//		"m_bHidden": false,
//		"m_bDelta": false,
//		"m_bLegacyWorldspace": false,
//		"m_bModelDoc": false,
//		"m_bImplicitSeqIgnoreDelta": false,
//		"m_bAnimGraphAdditive": false
//	},
//	"fps": 0.000000,
//	"m_pData":
//	{
//		"m_fileName": "",
//		"m_nFrames": 0,
//		"m_nFramesPerBlock": 0,
//		"m_frameblockArray":
//		[
//		],
//		"m_usageDifferences":
//		{
//			"m_boneArray":
//			[
//			],
//			"m_morphArray":
//			[
//			],
//			"m_userArray":
//			[
//			],
//			"m_bHasRotationBitArray":
//			[
//			],
//			"m_bHasMovementBitArray":
//			[
//			],
//			"m_bHasMorphBitArray":
//			[
//			],
//			"m_bHasUserBitArray":
//			[
//			]
//		}
//	},
//	"m_movementArray":
//	[
//	],
//	"m_xInitialOffset":
//	[
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000
//	],
//	"m_eventArray":
//	[
//	],
//	"m_activityArray":
//	[
//	],
//	"m_hierarchyArray":
//	[
//	],
//	"framestalltime": 0.000000,
//	"m_vecRootMin":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_vecRootMax":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_vecBoneWorldMin":
//	[
//	],
//	"m_vecBoneWorldMax":
//	[
//	],
//	"m_sequenceParams":
//	{
//		"m_flFadeInTime": 0.200000,
//		"m_flFadeOutTime": 0.200000
//	}
//}
class CAnimDesc
{
	CBufferString m_name;
	CAnimDesc_Flag m_flags;
	float32 fps;
	// MKV3TransferName = "m_pData"
	CAnimEncodedFrames m_Data;
	CUtlVector< CAnimMovement > m_movementArray;
	CTransform m_xInitialOffset;
	CUtlVector< CAnimEventDefinition > m_eventArray;
	CUtlVector< CAnimActivity > m_activityArray;
	CUtlVector< CAnimLocalHierarchy > m_hierarchyArray;
	float32 framestalltime;
	Vector m_vecRootMin;
	Vector m_vecRootMax;
	CUtlVector< Vector > m_vecBoneWorldMin;
	CUtlVector< Vector > m_vecBoneWorldMax;
	CAnimSequenceParams m_sequenceParams;
};
