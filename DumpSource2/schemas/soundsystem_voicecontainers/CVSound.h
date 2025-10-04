// MGetKV3ClassDefaults = {
//	"m_nRate": 0,
//	"m_nFormat": "PCM16",
//	"m_nChannels": 0,
//	"m_nLoopStart": 0,
//	"m_nSampleCount": 0,
//	"m_flDuration": 0.000000,
//	"m_Sentences":
//	[
//	],
//	"m_nStreamingSize": 0,
//	"m_nSeekTable":
//	[
//	],
//	"m_nLoopEnd": 0,
//	"m_encodedHeader": "[BINARY BLOB]"
//}
class CVSound
{
	int32 m_nRate;
	CVSoundFormat_t m_nFormat;
	uint32 m_nChannels;
	int32 m_nLoopStart;
	uint32 m_nSampleCount;
	float32 m_flDuration;
	CUtlVector< CAudioSentence > m_Sentences;
	uint32 m_nStreamingSize;
	CUtlVector< int32 > m_nSeekTable;
	int32 m_nLoopEnd;
	// MFgdFromSchemaCompletelySkipField
	CUtlBinaryBlock m_encodedHeader;
};
