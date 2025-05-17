// MNetworkVarNames = "CHandle< CBaseEntity> m_hCarriedHostage"
// MNetworkVarNames = "CHandle< CBaseEntity> m_hCarriedHostageProp"
class CCSPlayer_HostageServices : public CPlayerPawnComponent
{
	// MNetworkEnable
	CHandle< CBaseEntity > m_hCarriedHostage;
	// MNetworkEnable
	CHandle< CBaseEntity > m_hCarriedHostageProp;
};
