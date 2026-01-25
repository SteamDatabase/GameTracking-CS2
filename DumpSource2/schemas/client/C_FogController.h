// MEntityAllowsPortraitWorldSpawn
// MNetworkVarNames = "fogparams_t m_fog"
class C_FogController : public C_BaseEntity
{
	// MNetworkEnable
	// MNotSaved
	fogparams_t m_fog;
	bool m_bUseAngles;
	int32 m_iChangedVariables;
};
