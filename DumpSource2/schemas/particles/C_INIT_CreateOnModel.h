// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_CreateOnModel : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "input model"
	CParticleModelInput m_modelInput;
	// MPropertyFriendlyName = "input transform for transforming local space bias vector"
	// MParticleInputOptional
	CParticleTransformInput m_transformInput;
	// MPropertyFriendlyName = "force to be inside model"
	int32 m_nForceInModel;
	// MPropertyFriendlyName = "bias box distribution by volume"
	bool m_bScaleToVolume;
	// MPropertyFriendlyName = "even distribution within boxes"
	bool m_bEvenDistribution;
	// MPropertyFriendlyName = "desired hitbox"
	CParticleCollectionFloatInput m_nDesiredHitbox;
	// MPropertyFriendlyName = "Control Point Providing Hitbox index"
	int32 m_nHitboxValueFromControlPointIndex;
	// MPropertyFriendlyName = "hitbox scale"
	CParticleCollectionVecInput m_vecHitBoxScale;
	// MPropertyFriendlyName = "inherited velocity scale"
	float32 m_flBoneVelocity;
	// MPropertyFriendlyName = "maximum inherited velocity"
	float32 m_flMaxBoneVelocity;
	// MPropertyFriendlyName = "direction bias"
	// MVectorIsCoordinate
	CParticleCollectionVecInput m_vecDirectionBias;
	// MPropertyFriendlyName = "hitbox set"
	char[128] m_HitboxSetName;
	// MPropertyFriendlyName = "bias in local space"
	bool m_bLocalCoords;
	// MPropertyFriendlyName = "use bones instead of hitboxes"
	bool m_bUseBones;
	// MPropertyFriendlyName = "Use renderable meshes instead of hitboxes"
	bool m_bUseMesh;
	// MPropertyFriendlyName = "hitbox shell thickness"
	CParticleCollectionFloatInput m_flShellSize;
};
