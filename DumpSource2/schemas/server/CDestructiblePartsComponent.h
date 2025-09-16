// MNetworkVarNames = "CHandle< CBaseModelEntity > m_hOwner"
// MNetworkVarNames = "int m_nLastHitDamageLevel"
class CDestructiblePartsComponent
{
	CNetworkVarChainer __m_pChainEntity;
	CUtlVector< uint16 > m_vecDamageTakenByHitGroup;
	// MNetworkEnable
	CHandle< CBaseModelEntity > m_hOwner;
	// MNetworkEnable
	int32 m_nLastHitDamageLevel;
};
