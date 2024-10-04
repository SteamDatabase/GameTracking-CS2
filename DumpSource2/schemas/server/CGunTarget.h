class CGunTarget : public CBaseToggle
{
	bool m_on;
	CHandle< CBaseEntity > m_hTargetEnt;
	CEntityIOOutput m_OnDeath;
};
