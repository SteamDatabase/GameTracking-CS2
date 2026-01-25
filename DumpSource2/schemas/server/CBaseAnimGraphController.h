// MNetworkVarNames = "AnimationAlgorithm_t m_nAnimationAlgorithm"
// MNetworkVarNames = "CAnimGraphNetworkedVariables m_animGraphNetworkedVars"
// MNetworkVarNames = "CHandle< CBaseAnimGraph > m_vecSecondarySkeletons"
// MNetworkVarNames = "int m_nSecondarySkeletonMasterCount"
// MNetworkVarNames = "HSequence m_hSequence"
// MNetworkVarNames = "GameTime_t m_flSeqStartTime"
// MNetworkVarNames = "float m_flSeqFixedCycle"
// MNetworkVarNames = "AnimLoopMode_t m_nAnimLoopMode"
// MNetworkVarNames = "CNetworkedQuantizedFloat m_flPlaybackRate"
// MNetworkVarNames = "HNmGraphDefinitionStrong m_hGraphDefinitionAG2"
// MNetworkVarNames = "uint8 m_serializedPoseRecipeAG2"
// MNetworkVarNames = "int m_nSerializePoseRecipeSizeAG2"
// MNetworkVarNames = "int m_nSerializePoseRecipeVersionAG2"
// MNetworkVarNames = "int m_nServerGraphInstanceIteration"
// MNetworkVarNames = "int m_nServerSerializationContextIteration"
// MNetworkVarNames = "ResourceId_t m_primaryGraphId"
// MNetworkVarNames = "ResourceId_t m_vecExternalGraphIds"
// MNetworkVarNames = "ResourceId_t m_vecExternalClipIds"
class CBaseAnimGraphController : public CSkeletonAnimationController
{
	// MNetworkEnable
	// MNetworkChangeCallback = "AG2_OnAnimGraphDefinitionOrModeChanged"
	AnimationAlgorithm_t m_nAnimationAlgorithm;
	// MNetworkEnable
	CAnimGraphNetworkedVariables m_animGraphNetworkedVars;
	// MSaveOpsForField (UNKNOWN FOR PARSER)
	CSmartPtr< IAnimationGraphInstance > m_pAnimGraphInstance;
	ExternalAnimGraphHandle_t m_nNextExternalGraphHandle;
	CUtlVector< CGlobalSymbol > m_vecSecondarySkeletonNames;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnSecondarySkeletonsChanged"
	CNetworkUtlVectorBase< CHandle< CBaseAnimGraph > > m_vecSecondarySkeletons;
	// MNetworkEnable
	// MNetworkChangeCallback = "AG2_OnAnimGraphDefinitionOrModeChanged"
	int32 m_nSecondarySkeletonMasterCount;
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
	// MNetworkChangeCallback = "OnNetworkedAnimationChanged"
	// MNetworkPriority = 32
	CNetworkedQuantizedFloat m_flPlaybackRate;
	SequenceFinishNotifyState_t m_nNotifyState;
	bool m_bNetworkedAnimationInputsChanged;
	bool m_bNetworkedSequenceChanged;
	bool m_bLastUpdateSkipped;
	bool m_bSequenceFinished;
	GameTick_t m_nPrevAnimUpdateTick;
	// MNetworkEnable
	// MNetworkChangeCallback = "AG2_OnAnimGraphDefinitionOrModeChanged"
	CStrongHandle< InfoForResourceTypeCNmGraphDefinition > m_hGraphDefinitionAG2;
	// MNetworkEnable
	// MNotSaved
	CNetworkUtlVectorBase< uint8 > m_serializedPoseRecipeAG2;
	// MNetworkEnable
	// MNotSaved
	int32 m_nSerializePoseRecipeSizeAG2;
	// MNetworkEnable
	// MNotSaved
	int32 m_nSerializePoseRecipeVersionAG2;
	// MNetworkEnable
	// MNetworkChangeCallback = "AG2_OnAnimGraphSerializationContextInvalidated"
	int32 m_nServerGraphInstanceIteration;
	// MNetworkEnable
	// MNetworkChangeCallback = "AG2_OnAnimGraphSerializationContextInvalidated"
	int32 m_nServerSerializationContextIteration;
	// MNetworkEnable
	// MNetworkChangeCallback = "AG2_OnAnimGraphSerializationContextInvalidated"
	ResourceId_t m_primaryGraphId;
	// MNetworkEnable
	// MNetworkChangeCallback = "AG2_OnAnimGraphSerializationContextInvalidated"
	CNetworkUtlVectorBase< ResourceId_t > m_vecExternalGraphIds;
	// MNetworkEnable
	// MNetworkChangeCallback = "AG2_OnAnimGraphSerializationContextInvalidated"
	CNetworkUtlVectorBase< ResourceId_t > m_vecExternalClipIds;
	CGlobalSymbol m_sAnimGraph2Identifier;
	CUtlVector< ExternalAnimGraph_t > m_vecExternalGraphs;
};
