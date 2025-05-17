// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RenderClientPhysicsImpulse : public CParticleFunctionRenderer
{
	// MPropertyFriendlyName = "radius"
	CPerParticleFloatInput m_flRadius;
	// MPropertyFriendlyName = "magnitude"
	CPerParticleFloatInput m_flMagnitude;
	// MPropertyFriendlyName = "filter explosion to single simulation id"
	int32 m_nSimIdFilter;
};
