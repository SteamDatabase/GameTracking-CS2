// MNetworkVarNames = "CHandle< CBaseEntity> m_hCarriedHostage"
// MNetworkVarNames = "CHandle< CBaseEntity> m_hCarriedHostageProp"
class CCSPlayer_HostageServices : public CPlayerPawnComponent
{
	// MNetworkEnable
	CHandle< C_BaseEntity > m_hCarriedHostage;
	// MNetworkEnable
	CHandle< C_BaseEntity > m_hCarriedHostageProp;
};
