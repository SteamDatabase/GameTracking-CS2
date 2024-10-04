class CC4 : public CCSWeaponBase
{
	Vector m_vecLastValidPlayerHeldPosition;
	Vector m_vecLastValidDroppedPosition;
	bool m_bDoValidDroppedPositionCheck;
	bool m_bStartedArming;
	GameTime_t m_fArmedTime;
	bool m_bBombPlacedAnimation;
	bool m_bIsPlantingViaUse;
	EntitySpottedState_t m_entitySpottedState;
	int32 m_nSpotRules;
	bool[7] m_bPlayedArmingBeeps;
	bool m_bBombPlanted;
}
