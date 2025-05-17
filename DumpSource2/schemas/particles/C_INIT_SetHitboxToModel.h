// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_SetHitboxToModel : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "control point number"
	int32 m_nControlPointNumber;
	// MPropertyFriendlyName = "force to be inside model"
	int32 m_nForceInModel;
	// MPropertyFriendlyName = "even distribution"
	bool m_bEvenDistribution;
	// MPropertyFriendlyName = "desired hitbox"
	int32 m_nDesiredHitbox;
	// MPropertyFriendlyName = "model hitbox scale"
	CParticleCollectionVecInput m_vecHitBoxScale;
	// MPropertyFriendlyName = "direction bias"
	// MVectorIsCoordinate
	Vector m_vecDirectionBias;
	// MPropertyFriendlyName = "maintain existing hitbox"
	bool m_bMaintainHitbox;
	// MPropertyFriendlyName = "use bones instead of hitboxes"
	bool m_bUseBones;
	// MPropertyFriendlyName = "hitbox set"
	char[128] m_HitboxSetName;
	// MPropertyFriendlyName = "hitbox shell thickness"
	CParticleCollectionFloatInput m_flShellSize;
};
