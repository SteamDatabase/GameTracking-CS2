// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_InitialVelocityFromHitbox : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "velocity minimum"
	float32 m_flVelocityMin;
	// MPropertyFriendlyName = "velocity maximum"
	float32 m_flVelocityMax;
	// MPropertyFriendlyName = "control point number"
	int32 m_nControlPointNumber;
	// MPropertyFriendlyName = "hitbox set"
	char[128] m_HitboxSetName;
	// MPropertyFriendlyName = "use bones instead of hitboxes"
	bool m_bUseBones;
};
