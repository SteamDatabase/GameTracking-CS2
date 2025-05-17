// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RtEnvCull : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "test direction"
	// MVectorIsCoordinate
	Vector m_vecTestDir;
	// MPropertyFriendlyName = "cull normal"
	// MVectorIsCoordinate
	Vector m_vecTestNormal;
	// MPropertyFriendlyName = "cull on miss"
	bool m_bCullOnMiss;
	// MPropertyFriendlyName = "stick instead of cull"
	bool m_bStickInsteadOfCull;
	// MPropertyFriendlyName = "ray trace environment name"
	char[128] m_RtEnvName;
	// MPropertyFriendlyName = "ray trace environment cp"
	int32 m_nRTEnvCP;
	// MPropertyFriendlyName = "rt env control point component"
	// MPropertyAttributeChoiceName = "vector_component"
	int32 m_nComponent;
};
