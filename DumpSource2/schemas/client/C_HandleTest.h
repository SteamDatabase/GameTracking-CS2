// MNetworkVarNames = "CHandle< CBaseEntity> m_Handle"
// MNetworkVarNames = "bool m_bSendHandle"
class C_HandleTest : public C_BaseEntity
{
	// MNetworkEnable
	CHandle< C_BaseEntity > m_Handle;
	// MNetworkEnable
	bool m_bSendHandle;
};
