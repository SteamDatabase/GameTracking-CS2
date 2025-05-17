// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
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
