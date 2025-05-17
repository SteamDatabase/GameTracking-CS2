// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_SetControlPointToWaterSurface : public CParticleFunctionPreEmission
{
	// MPropertyFriendlyName = "source CP"
	int32 m_nSourceCP;
	// MPropertyFriendlyName = "CP to set to surface"
	int32 m_nDestCP;
	// MPropertyFriendlyName = "CP to set to surface current flow velocity"
	// MPropertySuppressExpr = "mod != hlx"
	int32 m_nFlowCP;
	// MPropertyFriendlyName = "CP to set component of if water"
	int32 m_nActiveCP;
	// MPropertyFriendlyName = "CP component"
	// MPropertyAttributeChoiceName = "vector_component"
	int32 m_nActiveCPField;
	// MPropertyFriendlyName = "retest rate"
	CParticleCollectionFloatInput m_flRetestRate;
	// MPropertyFriendlyName = "adaptive retest on moving surface"
	bool m_bAdaptiveThreshold;
};
