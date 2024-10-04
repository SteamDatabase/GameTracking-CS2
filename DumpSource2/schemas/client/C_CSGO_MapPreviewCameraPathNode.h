class C_CSGO_MapPreviewCameraPathNode : public C_BaseEntity
{
	CUtlSymbolLarge m_szParentPathUniqueID;
	int32 m_nPathIndex;
	Vector m_vInTangentLocal;
	Vector m_vOutTangentLocal;
	float32 m_flFOV;
	float32 m_flCameraSpeed;
	float32 m_flEaseIn;
	float32 m_flEaseOut;
	Vector m_vInTangentWorld;
	Vector m_vOutTangentWorld;
};
