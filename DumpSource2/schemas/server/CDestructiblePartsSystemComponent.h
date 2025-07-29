// MNetworkVarNames = "uint16_t m_DamageLevelTakenByHitGroup"
// MNetworkVarNames = "CHandle< CBaseModelEntity > m_hOwner"
// MNetworkVarNames = "int m_nLastHitDamageLevel"
class CDestructiblePartsSystemComponent
{
	CNetworkVarChainer __m_pChainEntity;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnDamageLevelTakenByHitGroupChanged"
	CNetworkUtlVectorBase< uint16 > m_DamageLevelTakenByHitGroup;
	// MNetworkEnable
	CHandle< CBaseModelEntity > m_hOwner;
	// MNetworkEnable
	int32 m_nLastHitDamageLevel;
};
