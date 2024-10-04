class C_OP_RenderTrails : public CBaseTrailRenderer
{
	bool m_bEnableFadingAndClamping;
	float32 m_flStartFadeDot;
	float32 m_flEndFadeDot;
	ParticleAttributeIndex_t m_nPrevPntSource;
	float32 m_flMaxLength;
	float32 m_flMinLength;
	bool m_bIgnoreDT;
	float32 m_flConstrainRadiusToLengthRatio;
	float32 m_flLengthScale;
	float32 m_flLengthFadeInTime;
	CPerParticleFloatInput m_flRadiusHeadTaper;
	CParticleCollectionVecInput m_vecHeadColorScale;
	CPerParticleFloatInput m_flHeadAlphaScale;
	CPerParticleFloatInput m_flRadiusTaper;
	CParticleCollectionVecInput m_vecTailColorScale;
	CPerParticleFloatInput m_flTailAlphaScale;
	ParticleAttributeIndex_t m_nHorizCropField;
	ParticleAttributeIndex_t m_nVertCropField;
	float32 m_flForwardShift;
	bool m_bFlipUVBasedOnPitchYaw;
};
