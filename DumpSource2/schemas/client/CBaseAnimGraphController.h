class CBaseAnimGraphController : public CSkeletonAnimationController
{
	CAnimGraphNetworkedVariables m_animGraphNetworkedVars;
	bool m_bSequenceFinished;
	float32 m_flSoundSyncTime;
	uint32 m_nActiveIKChainMask;
	HSequence m_hSequence;
	GameTime_t m_flSeqStartTime;
	float32 m_flSeqFixedCycle;
	AnimLoopMode_t m_nAnimLoopMode;
	CNetworkedQuantizedFloat m_flPlaybackRate;
	SequenceFinishNotifyState_t m_nNotifyState;
	bool m_bNetworkedAnimationInputsChanged;
	bool m_bNetworkedSequenceChanged;
	bool m_bLastUpdateSkipped;
	GameTime_t m_flPrevAnimUpdateTime;
}
