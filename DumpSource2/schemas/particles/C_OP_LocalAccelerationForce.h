// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_LocalAccelerationForce : public CParticleFunctionForce
{
	// MPropertyFriendlyName = "local space control point"
	int32 m_nCP;
	// MPropertyFriendlyName = "scale control point"
	int32 m_nScaleCP;
	// MPropertyFriendlyName = "local space acceleration"
	CParticleCollectionVecInput m_vecAccel;
};
