// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_RemapTransformOrientationToRotations : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "transform input"
	CParticleTransformInput m_TransformInput;
	// MPropertyFriendlyName = "offset pitch/yaw/roll"
	Vector m_vecRotation;
	// MPropertyFriendlyName = "Use Quaternians Internally"
	bool m_bUseQuat;
	// MPropertyFriendlyName = "Write normal instead of rotation"
	bool m_bWriteNormal;
};
