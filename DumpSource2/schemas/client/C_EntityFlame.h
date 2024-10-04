class C_EntityFlame : public C_BaseEntity
{
	CHandle< C_BaseEntity > m_hEntAttached;
	CHandle< C_BaseEntity > m_hOldAttached;
	bool m_bCheapEffect;
};
