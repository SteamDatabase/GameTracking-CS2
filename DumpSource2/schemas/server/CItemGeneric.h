class CItemGeneric : public CItem
{
	// MNotSaved
	bool m_bHasTriggerRadius;
	// MNotSaved
	bool m_bHasPickupRadius;
	// MNotSaved
	float32 m_flPickupRadiusSqr;
	// MNotSaved
	float32 m_flTriggerRadiusSqr;
	// MNotSaved
	GameTime_t m_flLastPickupCheck;
	// MNotSaved
	bool m_bPlayerCounterListenerAdded;
	// MNotSaved
	bool m_bPlayerInTriggerRadius;
	// MNotSaved
	CStrongHandle< InfoForResourceTypeIParticleSystemDefinition > m_hSpawnParticleEffect;
	// MNotSaved
	CUtlSymbolLarge m_pAmbientSoundEffect;
	// MNotSaved
	bool m_bAutoStartAmbientSound;
	// MNotSaved
	CUtlSymbolLarge m_pSpawnScriptFunction;
	// MNotSaved
	CStrongHandle< InfoForResourceTypeIParticleSystemDefinition > m_hPickupParticleEffect;
	// MNotSaved
	CUtlSymbolLarge m_pPickupSoundEffect;
	// MNotSaved
	CUtlSymbolLarge m_pPickupScriptFunction;
	// MNotSaved
	CStrongHandle< InfoForResourceTypeIParticleSystemDefinition > m_hTimeoutParticleEffect;
	// MNotSaved
	CUtlSymbolLarge m_pTimeoutSoundEffect;
	// MNotSaved
	CUtlSymbolLarge m_pTimeoutScriptFunction;
	// MNotSaved
	CUtlSymbolLarge m_pPickupFilterName;
	// MNotSaved
	CHandle< CBaseFilter > m_hPickupFilter;
	CEntityIOOutput m_OnPickup;
	CEntityIOOutput m_OnTimeout;
	CEntityIOOutput m_OnTriggerStartTouch;
	CEntityIOOutput m_OnTriggerTouch;
	CEntityIOOutput m_OnTriggerEndTouch;
	// MNotSaved
	CUtlSymbolLarge m_pAllowPickupScriptFunction;
	// MNotSaved
	float32 m_flPickupRadius;
	// MNotSaved
	float32 m_flTriggerRadius;
	// MNotSaved
	CUtlSymbolLarge m_pTriggerSoundEffect;
	// MNotSaved
	bool m_bGlowWhenInTrigger;
	// MNotSaved
	Color m_glowColor;
	// MNotSaved
	bool m_bUseable;
	// MNotSaved
	CHandle< CItemGenericTriggerHelper > m_hTriggerHelper;
};
