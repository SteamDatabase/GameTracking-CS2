class CSeqCmdSeqDesc
{
	CBufferString m_sName;
	CSeqSeqDescFlag m_flags;
	CSeqTransition m_transition;
	int16 m_nFrameRangeSequence;
	int16 m_nFrameCount;
	float32 m_flFPS;
	int16 m_nSubCycles;
	int16 m_numLocalResults;
	CUtlVector< CSeqCmdLayer > m_cmdLayerArray;
	CUtlVector< CAnimEventDefinition > m_eventArray;
	CUtlVector< CAnimActivity > m_activityArray;
	CUtlVector< CSeqPoseSetting > m_poseSettingArray;
}
