class CItemGeneric : public CItem
{
	bool m_bHasTriggerRadius;
	bool m_bHasPickupRadius;
	float32 m_flPickupRadiusSqr;
	float32 m_flTriggerRadiusSqr;
	GameTime_t m_flLastPickupCheck;
	bool m_bPlayerCounterListenerAdded;
	bool m_bPlayerInTriggerRadius;
	CStrongHandle< InfoForResourceTypeIParticleSystemDefinition > m_hSpawnParticleEffect;
	CUtlSymbolLarge m_pAmbientSoundEffect;
	bool m_bAutoStartAmbientSound;
	CUtlSymbolLarge m_pSpawnScriptFunction;
	CStrongHandle< InfoForResourceTypeIParticleSystemDefinition > m_hPickupParticleEffect;
	CUtlSymbolLarge m_pPickupSoundEffect;
	CUtlSymbolLarge m_pPickupScriptFunction;
	CStrongHandle< InfoForResourceTypeIParticleSystemDefinition > m_hTimeoutParticleEffect;
	CUtlSymbolLarge m_pTimeoutSoundEffect;
	CUtlSymbolLarge m_pTimeoutScriptFunction;
	CUtlSymbolLarge m_pPickupFilterName;
	CHandle< CBaseFilter > m_hPickupFilter;
	CEntityIOOutput m_OnPickup;
	CEntityIOOutput m_OnTimeout;
	CEntityIOOutput m_OnTriggerStartTouch;
	CEntityIOOutput m_OnTriggerTouch;
	CEntityIOOutput m_OnTriggerEndTouch;
	CUtlSymbolLarge m_pAllowPickupScriptFunction;
	float32 m_flPickupRadius;
	float32 m_flTriggerRadius;
	CUtlSymbolLarge m_pTriggerSoundEffect;
	bool m_bGlowWhenInTrigger;
	Color m_glowColor;
	bool m_bUseable;
	CHandle< CItemGenericTriggerHelper > m_hTriggerHelper;
}
