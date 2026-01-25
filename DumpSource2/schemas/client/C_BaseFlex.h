// MNetworkVarNames = "float32 m_flexWeight"
class C_BaseFlex : public CBaseAnimGraph
{
	// MNetworkEnable
	// MNetworkBitCount = 12
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 1.000000
	// MNetworkEncodeFlags = 1
	C_NetworkUtlVectorBase< float32 > m_flexWeight;
	// MNetworkEnable
	// MNetworkEncoder = "coord"
	// MNetworkChangeCallback = "OnViewTargetChanged"
	VectorWS m_vLookTargetPosition;
	// MNotSaved
	int32 m_nLastFlexUpdateFrameCount;
	// MNotSaved
	Vector m_CachedViewTarget;
	SceneEventId_t m_nNextSceneEventId;
	// MNotSaved
	AttachmentHandle_t m_iMouthAttachment;
	// MNotSaved
	AttachmentHandle_t m_iEyeAttachment;
	// MNotSaved
	bool m_bResetFlexWeightsOnModelChange;
	// MNotSaved
	int32 m_nEyeOcclusionRendererBone;
	// MNotSaved
	matrix3x4_t m_mEyeOcclusionRendererCameraToBoneTransform;
	// MNotSaved
	Vector m_vEyeOcclusionRendererHalfExtent;
	// MNotSaved
	C_BaseFlex::Emphasized_Phoneme[3] m_PhonemeClasses;
};
