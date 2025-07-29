// MNetworkVarNames = "uint16_t m_DamageLevelTakenByHitGroup"
// MNetworkVarNames = "CHandle< CBaseModelEntity > m_hOwner"
// MNetworkVarNames = "int m_nLastHitDamageLevel"
class CDestructiblePartsSystemComponent
{
	CNetworkVarChainer __m_pChainEntity;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnDamageLevelTakenByHitGroupChanged"
	C_NetworkUtlVectorBase< uint16 > m_DamageLevelTakenByHitGroup;
	// MNetworkEnable
	CHandle< C_BaseModelEntity > m_hOwner;
	// MNetworkEnable
	int32 m_nLastHitDamageLevel;
};
