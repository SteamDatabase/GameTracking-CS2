// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_SetGravityToCP : public CParticleFunctionPreEmission
{
	// MPropertyFriendlyName = "control point to sample gravity"
	int32 m_nCPInput;
	// MPropertyFriendlyName = "output control point"
	int32 m_nCPOutput;
	// MPropertyFriendlyName = "gravity scale"
	CParticleCollectionFloatInput m_flScale;
	// MPropertyFriendlyName = "set orientation"
	bool m_bSetOrientation;
	// MPropertyFriendlyName = "set gravity orientation to Z Down (instead of X)"
	// MPropertySuppressExpr = "!m_bSetOrientation"
	bool m_bSetZDown;
};
