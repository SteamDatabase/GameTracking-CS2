class CAnimReplayFrame
{
	CUtlVector< CUtlBinaryBlock > m_inputDataBlocks;
	CUtlBinaryBlock m_instanceData;
	CTransform m_startingLocalToWorldTransform;
	CTransform m_localToWorldTransform;
	float32 m_timeStamp;
};
