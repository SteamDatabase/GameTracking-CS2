// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_SetHitboxToClosest : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "control point number"
	int32 m_nControlPointNumber;
	// MPropertyFriendlyName = "desired hitbox"
	int32 m_nDesiredHitbox;
	// MPropertyFriendlyName = "model hitbox scale"
	CParticleCollectionVecInput m_vecHitBoxScale;
	// MPropertyFriendlyName = "hitbox set"
	char[128] m_HitboxSetName;
	// MPropertyFriendlyName = "use bones instead of hitboxes"
	bool m_bUseBones;
	// MPropertyFriendlyName = "get closest point on closest hitbox"
	bool m_bUseClosestPointOnHitbox;
	// MPropertyFriendlyName = "closest point test type"
	ClosestPointTestType_t m_nTestType;
	// MPropertyFriendlyName = "hybrid ratio"
	CParticleCollectionFloatInput m_flHybridRatio;
	// MPropertyFriendlyName = "set initial position"
	bool m_bUpdatePosition;
};
