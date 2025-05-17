// MNetworkVarNames = "bool m_bStartedArming"
// MNetworkVarNames = "GameTime_t m_fArmedTime"
// MNetworkVarNames = "bool m_bBombPlacedAnimation"
// MNetworkVarNames = "bool m_bIsPlantingViaUse"
// MNetworkVarNames = "EntitySpottedState_t m_entitySpottedState"
class CC4 : public CCSWeaponBase
{
	Vector m_vecLastValidPlayerHeldPosition;
	Vector m_vecLastValidDroppedPosition;
	bool m_bDoValidDroppedPositionCheck;
	// MNetworkEnable
	bool m_bStartedArming;
	// MNetworkEnable
	GameTime_t m_fArmedTime;
	// MNetworkEnable
	bool m_bBombPlacedAnimation;
	// MNetworkEnable
	bool m_bIsPlantingViaUse;
	// MNetworkEnable
	EntitySpottedState_t m_entitySpottedState;
	int32 m_nSpotRules;
	bool[7] m_bPlayedArmingBeeps;
	bool m_bBombPlanted;
};
