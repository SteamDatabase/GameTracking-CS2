// MNetworkVarNames = "float32 m_flexWeight"
// MNetworkVarNames = "bool m_blinktoggle"
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
	Vector m_vLookTargetPosition;
	// MNetworkEnable
	bool m_blinktoggle;
	int32 m_nLastFlexUpdateFrameCount;
	Vector m_CachedViewTarget;
	SceneEventId_t m_nNextSceneEventId;
	int32 m_iBlink;
	float32 m_blinktime;
	bool m_prevblinktoggle;
	int32 m_iJawOpen;
	float32 m_flJawOpenAmount;
	float32 m_flBlinkAmount;
	AttachmentHandle_t m_iMouthAttachment;
	AttachmentHandle_t m_iEyeAttachment;
	bool m_bResetFlexWeightsOnModelChange;
	int32 m_nEyeOcclusionRendererBone;
	matrix3x4_t m_mEyeOcclusionRendererCameraToBoneTransform;
	Vector m_vEyeOcclusionRendererHalfExtent;
	C_BaseFlex::Emphasized_Phoneme[3] m_PhonemeClasses;
};
