// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_Noise : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "output minimum"
	float32 m_flOutputMin;
	// MPropertyFriendlyName = "output maximum"
	float32 m_flOutputMax;
	// MPropertyFriendlyName = "noise coordinate scale"
	float32 m_fl4NoiseScale;
	// MPropertyFriendlyName = "additive"
	bool m_bAdditive;
	// MPropertyFriendlyName = "Noise animation time scale"
	float32 m_flNoiseAnimationTimeScale;
};
