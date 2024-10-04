class CBaseFlex : public CBaseAnimGraph
{
	CNetworkUtlVectorBase< float32 > m_flexWeight;
	Vector m_vLookTargetPosition;
	bool m_blinktoggle;
	GameTime_t m_flAllowResponsesEndTime;
	GameTime_t m_flLastFlexAnimationTime;
	SceneEventId_t m_nNextSceneEventId;
	bool m_bUpdateLayerPriorities;
};
