// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RemapExternalWindToCP : public CParticleFunctionPreEmission
{
	// MPropertyFriendlyName = "control point to sample wind"
	int32 m_nCP;
	// MPropertyFriendlyName = "output control point"
	int32 m_nCPOutput;
	// MPropertyFriendlyName = "wind scale"
	CParticleCollectionVecInput m_vecScale;
	// MPropertyFriendlyName = "set magnitude instead of vector"
	bool m_bSetMagnitude;
	// MPropertyFriendlyName = "magnitude output component"
	// MPropertyAttributeChoiceName = "vector_component"
	// MPropertySuppressExpr = "!m_bSetMagnitude"
	int32 m_nOutVectorField;
};
