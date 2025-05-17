// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_StopAfterCPDuration : public CParticleFunctionPreEmission
{
	// MPropertyFriendlyName = "duration at which to stop"
	CParticleCollectionFloatInput m_flDuration;
	// MPropertyFriendlyName = "destroy all particles immediately"
	bool m_bDestroyImmediately;
	// MPropertyFriendlyName = "play end cap effect"
	bool m_bPlayEndCap;
};
