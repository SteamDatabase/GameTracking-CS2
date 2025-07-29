// MNetworkVarNames = "bool m_ragEnabled"
// MNetworkVarNames = "Vector m_ragPos"
// MNetworkVarNames = "QAngle m_ragAngles"
// MNetworkVarNames = "EHANDLE m_hRagdollSource"
// MNetworkVarNames = "float32 m_flBlendWeight"
class CRagdollProp : public CBaseAnimGraph
{
	ragdoll_t m_ragdoll;
	bool m_bStartDisabled;
	// MNetworkEnable
	CNetworkUtlVectorBase< bool > m_ragEnabled;
	// MNetworkEnable
	// MNetworkEncoder = "coord"
	CNetworkUtlVectorBase< Vector > m_ragPos;
	// MNetworkEnable
	// MNetworkEncoder = "qangle"
	// MNetworkBitCount = 13
	CNetworkUtlVectorBase< QAngle > m_ragAngles;
	// MNetworkEnable
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
	bool m_bAllowStretch;
	// MNetworkEnable
	// MNetworkBitCount = 8
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 1.000000
	// MNetworkEncodeFlags = 1
	float32 m_flBlendWeight;
	float32 m_flDefaultFadeScale;
	CUtlVector< Vector > m_ragdollMins;
	CUtlVector< Vector > m_ragdollMaxs;
	bool m_bShouldDeleteActivationRecord;
	bool m_bValidatePoweredRagdollPose;
};
