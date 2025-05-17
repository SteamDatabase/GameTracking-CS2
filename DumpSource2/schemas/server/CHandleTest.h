// MNetworkVarNames = "CHandle< CBaseEntity> m_Handle"
// MNetworkVarNames = "bool m_bSendHandle"
class CHandleTest : public CBaseEntity
{
	// MNetworkEnable
	CHandle< CBaseEntity > m_Handle;
	// MNetworkEnable
	bool m_bSendHandle;
};
