// MNetworkVarNames = "CAnimGraphNetworkedVariables m_animGraphNetworkedVars"
// MNetworkVarNames = "HSequence m_hSequence"
// MNetworkVarNames = "GameTime_t m_flSeqStartTime"
// MNetworkVarNames = "float m_flSeqFixedCycle"
// MNetworkVarNames = "AnimLoopMode_t m_nAnimLoopMode"
class CBaseAnimGraphController : public CSkeletonAnimationController
{
	// MNetworkEnable
	CAnimGraphNetworkedVariables m_animGraphNetworkedVars;
	// MNetworkDisable
	bool m_bSequenceFinished;
	// MNetworkDisable
	float32 m_flSoundSyncTime;
	// MNetworkDisable
	uint32 m_nActiveIKChainMask;
	// MNetworkEnable
	// MNetworkSerializer = "minusone"
	// MNetworkChangeCallback = "OnNetworkedSequenceChanged"
	// MNetworkPriority = 32
	HSequence m_hSequence;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnNetworkedAnimationChanged"
	// MNetworkPriority = 32
	GameTime_t m_flSeqStartTime;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnNetworkedAnimationChanged"
	// MNetworkPriority = 32
	float32 m_flSeqFixedCycle;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnNetworkedAnimationChanged"
	// MNetworkPriority = 32
	AnimLoopMode_t m_nAnimLoopMode;
	// MNetworkEnable
	// MNetworkBitCount = 8
	// MNetworkMinValue = -4.000000
	// MNetworkMaxValue = 12.000000
	// MNetworkEncodeFlags = 5
	// MNetworkPriority = 32
	// MNetworkChangeCallback = "OnNetworkedAnimationChanged"
	CNetworkedQuantizedFloat m_flPlaybackRate;
	// MNetworkDisable
	SequenceFinishNotifyState_t m_nNotifyState;
	// MNetworkDisable
	bool m_bNetworkedAnimationInputsChanged;
	// MNetworkDisable
	bool m_bNetworkedSequenceChanged;
	// MNetworkDisable
	bool m_bLastUpdateSkipped;
	// MNetworkDisable
	GameTime_t m_flPrevAnimUpdateTime;
};
