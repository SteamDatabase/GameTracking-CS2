// MNetworkVarNames = "float32 m_flexWeight"
// MNetworkVarNames = "VectorWS m_vLookTargetPosition"
// MNetworkVarNames = "bool m_blinktoggle"
class CBaseFlex : public CBaseAnimGraph
{
	// MNetworkEnable
	// MNetworkBitCount = 12
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 1.000000
	// MNetworkEncodeFlags = 1
	CNetworkUtlVectorBase< float32 > m_flexWeight;
	// MNetworkEnable
	// MNetworkEncoder = "coord"
	VectorWS m_vLookTargetPosition;
	// MNetworkEnable
	bool m_blinktoggle;
	GameTime_t m_flAllowResponsesEndTime;
	GameTime_t m_flLastFlexAnimationTime;
	SceneEventId_t m_nNextSceneEventId;
	bool m_bUpdateLayerPriorities;
};
