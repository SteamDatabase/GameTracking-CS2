class CCSPlayer_WeaponServices : public CPlayer_WeaponServices
{
	GameTime_t m_flNextAttack;
	bool m_bIsLookingAtWeapon;
	bool m_bIsHoldingLookAtWeapon;
	uint32 m_nOldShootPositionHistoryCount;
	uint32 m_nOldInputHistoryCount;
}
