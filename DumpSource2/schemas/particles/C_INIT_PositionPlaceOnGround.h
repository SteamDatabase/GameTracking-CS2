// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_PositionPlaceOnGround : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "offset"
	CPerParticleFloatInput m_flOffset;
	// MPropertyFriendlyName = "max trace length"
	CPerParticleFloatInput m_flMaxTraceLength;
	// MPropertyFriendlyName = "collision group"
	char[128] m_CollisionGroupName;
	// MPropertyFriendlyName = "Trace Set"
	ParticleTraceSet_t m_nTraceSet;
	// MPropertyFriendlyName = "No Collision Behavior"
	ParticleTraceMissBehavior_t m_nTraceMissBehavior;
	// MPropertyFriendlyName = "include water"
	// MPropertySuppressExpr = "m_nTraceSet == PARTICLE_TRACE_SET_STATIC"
	bool m_bIncludeWater;
	// MPropertyFriendlyName = "set normal"
	bool m_bSetNormal;
	// MPropertyFriendlyName = "Attribute to Set"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nAttribute;
	// MPropertyFriendlyName = "set Previous XYZ only"
	// MPropertySuppressExpr = "m_nAttribute != PARTICLE_ATTRIBUTE_XYZ"
	bool m_bSetPXYZOnly;
	// MPropertyFriendlyName = "Trace along particle normal"
	bool m_bTraceAlongNormal;
	// MPropertyFriendlyName = "Attribute for Trace Direction"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	// MPropertySuppressExpr = "!m_bTraceAlongNormal"
	ParticleAttributeIndex_t m_nTraceDirectionAttribute;
	// MPropertyFriendlyName = "Offset only if trace hit"
	bool m_bOffsetonColOnly;
	// MPropertyFriendlyName = "offset final position by this fraction of the particle radius"
	float32 m_flOffsetByRadiusFactor;
	// MPropertyFriendlyName = "preserve initial Z-offset relative to cp"
	int32 m_nPreserveOffsetCP;
	// MPropertyFriendlyName = "CP Entity to Ignore for Collisions"
	// MPropertySuppressExpr = "m_nTraceSet == PARTICLE_TRACE_SET_STATIC"
	int32 m_nIgnoreCP;
};
