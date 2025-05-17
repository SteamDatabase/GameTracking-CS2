// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_DistanceBetweenCPsToCP : public CParticleFunctionPreEmission
{
	// MPropertyFriendlyName = "starting control point"
	int32 m_nStartCP;
	// MPropertyFriendlyName = "ending control point"
	int32 m_nEndCP;
	// MPropertyFriendlyName = "output control point"
	int32 m_nOutputCP;
	// MPropertyFriendlyName = "output control point field"
	int32 m_nOutputCPField;
	// MPropertyFriendlyName = "only set distance once"
	bool m_bSetOnce;
	// MPropertyFriendlyName = "distance minimum"
	float32 m_flInputMin;
	// MPropertyFriendlyName = "distance maximum"
	float32 m_flInputMax;
	// MPropertyFriendlyName = "output minimum"
	float32 m_flOutputMin;
	// MPropertyFriendlyName = "output maximum"
	float32 m_flOutputMax;
	// MPropertyFriendlyName = "maximum trace length"
	float32 m_flMaxTraceLength;
	// MPropertyFriendlyName = "LOS Failure Scale"
	float32 m_flLOSScale;
	// MPropertyFriendlyName = "ensure line of sight"
	bool m_bLOS;
	// MPropertyFriendlyName = "LOS collision group"
	char[128] m_CollisionGroupName;
	// MPropertyFriendlyName = "Trace Set"
	ParticleTraceSet_t m_nTraceSet;
	// MPropertyFriendlyName = "set parent"
	ParticleParentSetMode_t m_nSetParent;
};
