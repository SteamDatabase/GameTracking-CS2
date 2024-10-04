class CPlayer_WeaponServices : public CPlayerPawnComponent
{
	CNetworkUtlVectorBase< CHandle< CBasePlayerWeapon > > m_hMyWeapons;
	CHandle< CBasePlayerWeapon > m_hActiveWeapon;
	CHandle< CBasePlayerWeapon > m_hLastWeapon;
	uint16[32] m_iAmmo;
	bool m_bPreventWeaponPickup;
}
