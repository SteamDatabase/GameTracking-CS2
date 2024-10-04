class CBaseTrailRenderer : public CBaseRendererSource2
{
	ParticleOrientationChoiceList_t m_nOrientationType;
	int32 m_nOrientationControlPoint;
	float32 m_flMinSize;
	float32 m_flMaxSize;
	CParticleCollectionRendererFloatInput m_flStartFadeSize;
	CParticleCollectionRendererFloatInput m_flEndFadeSize;
	bool m_bClampV;
};
