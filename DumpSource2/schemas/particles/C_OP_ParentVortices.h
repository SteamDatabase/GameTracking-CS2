// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_ParentVortices : public CParticleFunctionForce
{
	// MPropertyFriendlyName = "amount of force"
	float32 m_flForceScale;
	// MPropertyFriendlyName = "twist axis"
	// MVectorIsCoordinate
	Vector m_vecTwistAxis;
	// MPropertyFriendlyName = "flip twist axis with yaw"
	bool m_bFlipBasedOnYaw;
};
