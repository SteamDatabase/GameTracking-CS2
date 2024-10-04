class CBasePlayerWeapon : public CEconEntity
{
	GameTick_t m_nNextPrimaryAttackTick;
	float32 m_flNextPrimaryAttackTickRatio;
	GameTick_t m_nNextSecondaryAttackTick;
	float32 m_flNextSecondaryAttackTickRatio;
	int32 m_iClip1;
	int32 m_iClip2;
	int32[2] m_pReserveAmmo;
	CEntityIOOutput m_OnPlayerUse;
}
