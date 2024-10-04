class CCSPlayer_WeaponServices : public CPlayer_WeaponServices
{
	GameTime_t m_flNextAttack;
	bool m_bIsLookingAtWeapon;
	bool m_bIsHoldingLookAtWeapon;
	CHandle< CBasePlayerWeapon > m_hSavedWeapon;
	int32 m_nTimeToMelee;
	int32 m_nTimeToSecondary;
	int32 m_nTimeToPrimary;
	int32 m_nTimeToSniperRifle;
	bool m_bIsBeingGivenItem;
	bool m_bIsPickingUpItemWithUse;
	bool m_bPickedUpWeapon;
	bool m_bDisableAutoDeploy;
	bool m_bIsPickingUpGroundWeapon;
	uint32 m_nOldShootPositionHistoryCount;
	uint32 m_nOldInputHistoryCount;
};
