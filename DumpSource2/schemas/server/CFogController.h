// MEntityAllowsPortraitWorldSpawn
// MNetworkVarNames = "fogparams_t m_fog"
class CFogController : public CBaseEntity
{
	// MNetworkEnable
	// MNotSaved
	fogparams_t m_fog;
	bool m_bUseAngles;
	int32 m_iChangedVariables;
};
