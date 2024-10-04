class C_OP_RemapAverageHitboxSpeedtoCP : public CParticleFunctionPreEmission
{
	int32 m_nInControlPointNumber;
	int32 m_nOutControlPointNumber;
	int32 m_nField;
	ParticleHitboxDataSelection_t m_nHitboxDataType;
	CParticleCollectionFloatInput m_flInputMin;
	CParticleCollectionFloatInput m_flInputMax;
	CParticleCollectionFloatInput m_flOutputMin;
	CParticleCollectionFloatInput m_flOutputMax;
	int32 m_nHeightControlPointNumber;
	CParticleCollectionVecInput m_vecComparisonVelocity;
	char[128] m_HitboxSetName;
};
