// MNetworkVarNames = "bool m_bStartedArming"
// MNetworkVarNames = "GameTime_t m_fArmedTime"
// MNetworkVarNames = "bool m_bBombPlacedAnimation"
// MNetworkVarNames = "bool m_bIsPlantingViaUse"
// MNetworkVarNames = "EntitySpottedState_t m_entitySpottedState"
class C_C4 : public C_CSWeaponBase
{
	char[32] m_szScreenText;
	ParticleIndex_t m_activeLightParticleIndex;
	C4LightEffect_t m_eActiveLightEffect;
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
