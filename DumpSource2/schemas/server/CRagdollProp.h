class CRagdollProp : public CBaseAnimGraph
{
	ragdoll_t m_ragdoll;
	bool m_bStartDisabled;
	CNetworkUtlVectorBase< Vector > m_ragPos;
	CNetworkUtlVectorBase< QAngle > m_ragAngles;
	CHandle< CBaseEntity > m_hRagdollSource;
	uint32 m_lastUpdateTickCount;
	bool m_allAsleep;
	bool m_bFirstCollisionAfterLaunch;
	CHandle< CBaseEntity > m_hDamageEntity;
	CHandle< CBaseEntity > m_hKiller;
	CHandle< CBasePlayerPawn > m_hPhysicsAttacker;
	GameTime_t m_flLastPhysicsInfluenceTime;
	GameTime_t m_flFadeOutStartTime;
	float32 m_flFadeTime;
	Vector m_vecLastOrigin;
	GameTime_t m_flAwakeTime;
	GameTime_t m_flLastOriginChangeTime;
	CUtlSymbolLarge m_strOriginClassName;
	CUtlSymbolLarge m_strSourceClassName;
	bool m_bHasBeenPhysgunned;
	bool m_bShouldTeleportPhysics;
	float32 m_flBlendWeight;
	float32 m_flDefaultFadeScale;
	CUtlVector< Vector > m_ragdollMins;
	CUtlVector< Vector > m_ragdollMaxs;
	bool m_bShouldDeleteActivationRecord;
	bool m_bValidatePoweredRagdollPose;
}
