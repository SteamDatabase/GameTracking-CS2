// MNetworkVarNames = "CAnimGraphNetworkedVariables m_animGraphNetworkedVars"
// MNetworkVarNames = "HSequence m_hSequence"
// MNetworkVarNames = "GameTime_t m_flSeqStartTime"
// MNetworkVarNames = "float m_flSeqFixedCycle"
// MNetworkVarNames = "AnimLoopMode_t m_nAnimLoopMode"
// MNetworkVarNames = "HNmGraphDefinitionStrong m_hGraphDefinitionAG2"
// MNetworkVarNames = "bool m_bIsUsingAG2"
// MNetworkVarNames = "uint8 m_serializedPoseRecipeAG2"
// MNetworkVarNames = "int m_nSerializePoseRecipeSizeAG2"
// MNetworkVarNames = "int m_nSerializePoseRecipeVersionAG2"
// MNetworkVarNames = "uint8 m_nGraphCreationFlagsAG2"
// MNetworkVarNames = "int m_nServerGraphDefReloadCountAG2"
class CBaseAnimGraphController : public CSkeletonAnimationController
{
	// MNetworkEnable
	CAnimGraphNetworkedVariables m_animGraphNetworkedVars;
	bool m_bSequenceFinished;
	float32 m_flSoundSyncTime;
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
	SequenceFinishNotifyState_t m_nNotifyState;
	bool m_bNetworkedAnimationInputsChanged;
	bool m_bNetworkedSequenceChanged;
	bool m_bLastUpdateSkipped;
	GameTime_t m_flPrevAnimUpdateTime;
	// MNetworkEnable
	// MNetworkChangeCallback = "AG2_OnAnimGraphDefinitionOrModeChanged"
	CStrongHandle< InfoForResourceTypeCNmGraphDefinition > m_hGraphDefinitionAG2;
	// MNetworkEnable
	// MNetworkChangeCallback = "AG2_OnAnimGraphDefinitionOrModeChanged"
	bool m_bIsUsingAG2;
	// MNetworkEnable
	CNetworkUtlVectorBase< uint8 > m_serializedPoseRecipeAG2;
	// MNetworkEnable
	int32 m_nSerializePoseRecipeSizeAG2;
	// MNetworkEnable
	int32 m_nSerializePoseRecipeVersionAG2;
	// MNetworkEnable
	uint8 m_nGraphCreationFlagsAG2;
	// MNetworkEnable
	int32 m_nServerGraphDefReloadCountAG2;
};
