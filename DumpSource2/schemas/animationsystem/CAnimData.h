// MGetKV3ClassDefaults = {
//	"m_name": "",
//	"m_animArray":
//	[
//	],
//	"m_decoderArray":
//	[
//	],
//	"m_nMaxUniqueFrameIndex": 0,
//	"m_segmentArray":
//	[
//	]
//}
class CAnimData
{
	CBufferString m_name;
	CUtlVector< CAnimDesc > m_animArray;
	CUtlVector< CAnimDecoder > m_decoderArray;
	int32 m_nMaxUniqueFrameIndex;
	CUtlVector< CAnimFrameSegment > m_segmentArray;
};
