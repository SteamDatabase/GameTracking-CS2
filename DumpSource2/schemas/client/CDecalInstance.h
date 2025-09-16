class CDecalInstance
{
	CGlobalSymbol m_sDecalGroup;
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_hMaterial;
	CUtlStringToken m_sSequenceName;
	CHandle< C_BaseEntity > m_hEntity;
	int32 m_nBoneIndex;
	Vector m_vPositionLS;
	Vector m_vNormalLS;
	Vector m_vSAxisLS;
	DecalFlags_t m_nFlags;
	Color m_Color;
	float32 m_flWidth;
	float32 m_flHeight;
	float32 m_flDepth;
	float32 m_flAnimationScale;
	GameTime_t m_flPlaceTime;
	float32 m_flFadeStartTime;
	float32 m_flFadeDuration;
	float32 m_flLightingOriginOffset;
	float32 m_flBoundingRadiusSqr;
	int16 m_nSequenceIndex;
	bool m_bIsAdjacent;
	bool m_bDoDecalLightmapping;
	CDecalInstance* m_pNext;
	CDecalInstance* m_pPrev;
};
