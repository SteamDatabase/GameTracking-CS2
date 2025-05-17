// MNetworkVarNames = "CHandle< CCSPlayerPawn> m_hPlayer"
// MNetworkVarNames = "CHandle< CBaseEntity> m_hPingedEntity"
// MNetworkVarNames = "int m_iType"
// MNetworkVarNames = "bool m_bUrgent"
// MNetworkVarNames = "char m_szPlaceName"
class C_PlayerPing : public C_BaseEntity
{
	// MNetworkEnable
	CHandle< C_CSPlayerPawn > m_hPlayer;
	// MNetworkEnable
	CHandle< C_BaseEntity > m_hPingedEntity;
	// MNetworkEnable
	int32 m_iType;
	// MNetworkEnable
	bool m_bUrgent;
	// MNetworkEnable
	char[18] m_szPlaceName;
};
