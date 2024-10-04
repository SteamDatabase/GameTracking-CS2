class CSingleFrameUpdateNode : public CLeafUpdateNode
{
	CUtlVector< CSmartPtr< CAnimActionUpdater > > m_actions;
	CPoseHandle m_hPoseCacheHandle;
	HSequence m_hSequence;
	float32 m_flCycle;
}
