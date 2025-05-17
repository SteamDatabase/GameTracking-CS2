// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_DistanceToCPInit : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "distance minimum"
	CPerParticleFloatInput m_flInputMin;
	// MPropertyFriendlyName = "distance maximum"
	CPerParticleFloatInput m_flInputMax;
	// MPropertyFriendlyName = "output minimum"
	CPerParticleFloatInput m_flOutputMin;
	// MPropertyFriendlyName = "output maximum"
	CPerParticleFloatInput m_flOutputMax;
	// MPropertyFriendlyName = "control point"
	int32 m_nStartCP;
	// MPropertyFriendlyName = "ensure line of sight"
	bool m_bLOS;
	// MPropertyFriendlyName = "LOS collision group"
	char[128] m_CollisionGroupName;
	// MPropertyFriendlyName = "Trace Set"
	ParticleTraceSet_t m_nTraceSet;
	// MPropertyFriendlyName = "Maximum Trace Length"
	CPerParticleFloatInput m_flMaxTraceLength;
	// MPropertyFriendlyName = "LOS Failure Scalar"
	float32 m_flLOSScale;
	// MPropertyFriendlyName = "set value method"
	ParticleSetMethod_t m_nSetMethod;
	// MPropertyFriendlyName = "only active within specified distance"
	bool m_bActiveRange;
	// MPropertyFriendlyName = "distance component scale"
	Vector m_vecDistanceScale;
	// MPropertyFriendlyName = "remap bias"
	float32 m_flRemapBias;
};
