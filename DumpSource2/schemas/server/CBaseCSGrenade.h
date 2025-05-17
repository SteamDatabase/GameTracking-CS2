// MNetworkVarNames = "bool m_bRedraw"
// MNetworkVarNames = "bool m_bIsHeldByPlayer"
// MNetworkVarNames = "bool m_bPinPulled"
// MNetworkVarNames = "bool m_bJumpThrow"
// MNetworkVarNames = "bool m_bThrowAnimating"
// MNetworkVarNames = "GameTime_t m_fThrowTime"
// MNetworkVarNames = "float m_flThrowStrength"
// MNetworkVarNames = "float m_flThrowStrengthApproach"
// MNetworkVarNames = "GameTime_t m_fDropTime"
// MNetworkVarNames = "GameTime_t m_fPinPullTime"
// MNetworkVarNames = "bool m_bJustPulledPin"
// MNetworkVarNames = "GameTick_t m_nNextHoldTick"
// MNetworkVarNames = "float m_flNextHoldFrac"
// MNetworkVarNames = "CHandle< CCSWeaponBase> m_hSwitchToWeaponAfterThrow"
class CBaseCSGrenade : public CCSWeaponBase
{
	// MNetworkEnable
	bool m_bRedraw;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnGrenadeStateChanged"
	bool m_bIsHeldByPlayer;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnGrenadeStateChanged"
	bool m_bPinPulled;
	// MNetworkEnable
	bool m_bJumpThrow;
	// MNetworkEnable
	bool m_bThrowAnimating;
	// MNetworkEnable
	GameTime_t m_fThrowTime;
	// MNetworkEnable
	float32 m_flThrowStrength;
	// MNetworkEnable
	float32 m_flThrowStrengthApproach;
	// MNetworkEnable
	GameTime_t m_fDropTime;
	// MNetworkEnable
	GameTime_t m_fPinPullTime;
	// MNetworkEnable
	bool m_bJustPulledPin;
	// MNetworkEnable
	GameTick_t m_nNextHoldTick;
	// MNetworkEnable
	float32 m_flNextHoldFrac;
	// MNetworkEnable
	CHandle< CCSWeaponBase > m_hSwitchToWeaponAfterThrow;
};
