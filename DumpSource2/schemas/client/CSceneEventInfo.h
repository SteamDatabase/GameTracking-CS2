class CSceneEventInfo
{
	int32 m_iLayer;
	int32 m_iPriority;
	HSequence m_hSequence;
	float32 m_flWeight;
	bool m_bHasArrived;
	int32 m_nType;
	GameTime_t m_flNext;
	bool m_bIsGesture;
	bool m_bShouldRemove;
	CHandle< C_BaseEntity > m_hTarget;
	SceneEventId_t m_nSceneEventId;
	bool m_bClientSide;
	bool m_bStarted;
};
