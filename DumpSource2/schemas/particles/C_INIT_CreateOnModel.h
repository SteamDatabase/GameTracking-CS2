class C_INIT_CreateOnModel : public CParticleFunctionInitializer
{
	CParticleModelInput m_modelInput;
	CParticleTransformInput m_transformInput;
	int32 m_nForceInModel;
	bool m_bScaleToVolume;
	bool m_bEvenDistribution;
	CParticleCollectionFloatInput m_nDesiredHitbox;
	int32 m_nHitboxValueFromControlPointIndex;
	CParticleCollectionVecInput m_vecHitBoxScale;
	float32 m_flBoneVelocity;
	float32 m_flMaxBoneVelocity;
	CParticleCollectionVecInput m_vecDirectionBias;
	char[128] m_HitboxSetName;
	bool m_bLocalCoords;
	bool m_bUseBones;
	bool m_bUseMesh;
	CParticleCollectionFloatInput m_flShellSize;
};
