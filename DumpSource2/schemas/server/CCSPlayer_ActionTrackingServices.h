class CCSPlayer_ActionTrackingServices : public CPlayerPawnComponent
{
	CHandle< CBasePlayerWeapon > m_hLastWeaponBeforeC4AutoSwitch;
	bool m_bIsRescuing;
	WeaponPurchaseTracker_t m_weaponPurchasesThisMatch;
	WeaponPurchaseTracker_t m_weaponPurchasesThisRound;
}
