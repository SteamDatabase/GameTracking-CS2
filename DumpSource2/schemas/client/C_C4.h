class C_C4 : public C_CSWeaponBase
{
	char[32] m_szScreenText;
	ParticleIndex_t m_activeLightParticleIndex;
	C4LightEffect_t m_eActiveLightEffect;
	bool m_bStartedArming;
	GameTime_t m_fArmedTime;
	bool m_bBombPlacedAnimation;
	bool m_bIsPlantingViaUse;
	EntitySpottedState_t m_entitySpottedState;
	int32 m_nSpotRules;
	bool[7] m_bPlayedArmingBeeps;
	bool m_bBombPlanted;
};
