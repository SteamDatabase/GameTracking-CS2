// MGetKV3ClassDefaults = {
//	"m_fileName": "",
//	"m_nFrames": 0,
//	"m_nFramesPerBlock": 0,
//	"m_frameblockArray":
//	[
//	],
//	"m_usageDifferences":
//	{
//		"m_boneArray":
//		[
//		],
//		"m_morphArray":
//		[
//		],
//		"m_userArray":
//		[
//		],
//		"m_bHasRotationBitArray":
//		[
//		],
//		"m_bHasMovementBitArray":
//		[
//		],
//		"m_bHasMorphBitArray":
//		[
//		],
//		"m_bHasUserBitArray":
//		[
//		]
//	}
//}
class CAnimEncodedFrames
{
	CBufferString m_fileName;
	int32 m_nFrames;
	int32 m_nFramesPerBlock;
	CUtlVector< CAnimFrameBlockAnim > m_frameblockArray;
	CAnimEncodeDifference m_usageDifferences;
};
