class CFists : public CCSWeaponBase
{
	bool m_bPlayingUninterruptableAct;
	PlayerAnimEvent_t m_nUninterruptableActivity;
	bool m_bRestorePrevWep;
	CHandle< CBasePlayerWeapon > m_hWeaponBeforePrevious;
	CHandle< CBasePlayerWeapon > m_hWeaponPrevious;
	bool m_bDelayedHardPunchIncoming;
	bool m_bDestroyAfterTaunt;
}
