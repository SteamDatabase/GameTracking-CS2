class CDecalInfo
{
	float32 m_flAnimationScale;
	float32 m_flAnimationLifeSpan;
	float32 m_flPlaceTime;
	float32 m_flFadeStartTime;
	float32 m_flFadeDuration;
	int32 m_nVBSlot;
	int32 m_nBoneIndex;
	Vector m_vPosition;
	float32 m_flBoundingRadiusSqr;
	CDecalInfo* m_pNext;
	CDecalInfo* m_pPrev;
	int32 m_nDecalMaterialIndex;
}
