// MNetworkVarNames = "CHandle< C_BaseEntity> m_hEntAttached"
// MNetworkVarNames = "bool m_bCheapEffect"
class C_EntityFlame : public C_BaseEntity
{
	// MNetworkEnable
	CHandle< C_BaseEntity > m_hEntAttached;
	CHandle< C_BaseEntity > m_hOldAttached;
	// MNetworkEnable
	bool m_bCheapEffect;
};
