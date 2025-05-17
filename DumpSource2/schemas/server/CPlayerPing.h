// MNetworkVarNames = "CHandle< CCSPlayerPawn> m_hPlayer"
// MNetworkVarNames = "CHandle< CBaseEntity> m_hPingedEntity"
// MNetworkVarNames = "int m_iType"
// MNetworkVarNames = "bool m_bUrgent"
// MNetworkVarNames = "char m_szPlaceName"
class CPlayerPing : public CBaseEntity
{
	// MNetworkEnable
	CHandle< CCSPlayerPawn > m_hPlayer;
	// MNetworkEnable
	CHandle< CBaseEntity > m_hPingedEntity;
	// MNetworkEnable
	int32 m_iType;
	// MNetworkEnable
	bool m_bUrgent;
	// MNetworkEnable
	char[18] m_szPlaceName;
};
