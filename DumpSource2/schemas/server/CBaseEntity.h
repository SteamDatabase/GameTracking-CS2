// MNetworkExcludeByName = "m_bClientSideRagdoll"
// MNetworkExcludeByName = "m_iMaxHealth"
// MNetworkExcludeByUserGroup = "Water"
// MNetworkExcludeByUserGroup = "Player"
// MNetworkExcludeByUserGroup = "LocalPlayerExclusive"
// MNetworkExcludeByName = "m_spawnflags"
// MNetworkExcludeByName = "m_bTakesDamage"
// MNetworkExcludeByName = "m_nTakeDamageFlags"
// MNetworkExcludeByName = "m_flSpeed"
// MNetworkVarNames = "CBodyComponent::Storage_t m_CBodyComponent"
// MNetworkVarNames = "int32 m_iHealth"
// MNetworkVarNames = "int32 m_iMaxHealth"
// MNetworkVarNames = "uint8 m_lifeState"
// MNetworkVarNames = "bool m_bTakesDamage"
// MNetworkVarNames = "TakeDamageFlags_t m_nTakeDamageFlags"
// MNetworkVarNames = "EntityPlatformTypes_t m_nPlatformType"
// MNetworkVarNames = "MoveCollide_t m_MoveCollide"
// MNetworkVarNames = "MoveType_t m_MoveType"
// MNetworkVarNames = "EntitySubclassID_t m_nSubclassID"
// MNetworkVarNames = "float32 m_flAnimTime"
// MNetworkVarNames = "float32 m_flSimulationTime"
// MNetworkVarNames = "GameTime_t m_flCreateTime"
// MNetworkVarNames = "bool m_bClientSideRagdoll"
// MNetworkVarNames = "uint8 m_ubInterpolationFrame"
// MNetworkVarNames = "uint8 m_iTeamNum"
// MNetworkVarNames = "float m_flSpeed"
// MNetworkVarNames = "uint32 m_spawnflags"
// MNetworkVarNames = "GameTick_t m_nNextThinkTick"
// MNetworkVarNames = "uint32 m_fFlags"
// MNetworkVarNames = "CNetworkVelocityVector m_vecVelocity"
// MNetworkVarNames = "Vector m_vecBaseVelocity"
// MNetworkVarNames = "CHandle< CBaseEntity> m_hEffectEntity"
// MNetworkVarNames = "CHandle< CBaseEntity> m_hOwnerEntity"
// MNetworkVarNames = "uint32 m_fEffects"
// MNetworkVarNames = "CHandle< CBaseEntity> m_hGroundEntity"
// MNetworkVarNames = "int m_nGroundBodyIndex"
// MNetworkVarNames = "float32 m_flFriction"
// MNetworkVarNames = "float32 m_flElasticity"
// MNetworkVarNames = "float32 m_flGravityScale"
// MNetworkVarNames = "float32 m_flTimeScale"
// MNetworkVarNames = "float m_flWaterLevel"
// MNetworkVarNames = "bool m_bAnimatedEveryTick"
// MNetworkVarNames = "GameTime_t m_flNavIgnoreUntilTime"
// MNetworkVarNames = "BloodType m_nBloodType"
class CBaseEntity : public CEntityInstance
{
	// MNetworkEnable
	// MNetworkUserGroup = "CBodyComponent"
	// MNetworkAlias = "CBodyComponent"
	// MNetworkTypeAlias = "CBodyComponent"
	// MNetworkPriority = 48
	CBodyComponent* m_CBodyComponent;
	CNetworkTransmitComponent m_NetworkTransmitComponent;
	CUtlVector< thinkfunc_t > m_aThinkFunctions;
	int32 m_iCurrentThinkContext;
	GameTick_t m_nLastThinkTick;
	bool m_bDisabledContextThinks;
	CTypedBitVec< 64 > m_isSteadyState;
	float32 m_lastNetworkChange;
	CUtlVector< ResponseContext_t > m_ResponseContexts;
	CUtlSymbolLarge m_iszResponseContext;
	// MNetworkEnable
	// MNetworkSerializer = "ClampHealth"
	// MNetworkUserGroup = "Player"
	// MNetworkPriority = 32
	int32 m_iHealth;
	// MNetworkEnable
	int32 m_iMaxHealth;
	// MNetworkEnable
	// MNetworkUserGroup = "Player"
	// MNetworkPriority = 32
	uint8 m_lifeState;
	float32 m_flDamageAccumulator;
	// MNetworkEnable
	bool m_bTakesDamage;
	// MNetworkEnable
	TakeDamageFlags_t m_nTakeDamageFlags;
	// MNetworkEnable
	EntityPlatformTypes_t m_nPlatformType;
	// MNetworkEnable
	MoveCollide_t m_MoveCollide;
	// MNetworkEnable
	MoveType_t m_MoveType;
	MoveType_t m_nActualMoveType;
	uint8 m_nWaterTouch;
	uint8 m_nSlimeTouch;
	bool m_bRestoreInHierarchy;
	CUtlSymbolLarge m_target;
	CHandle< CBaseFilter > m_hDamageFilter;
	CUtlSymbolLarge m_iszDamageFilterName;
	float32 m_flMoveDoneTime;
	// MNetworkEnable
	// MNetworkSendProxyRecipientsFilter (UNKNOWN FOR PARSER)
	CUtlStringToken m_nSubclassID;
	// MNetworkEnable
	// MNetworkPriority = 0
	// MNetworkSerializer = "animTimeSerializer"
	// MNetworkSendProxyRecipientsFilter (UNKNOWN FOR PARSER)
	float32 m_flAnimTime;
	// MNetworkEnable
	// MNetworkPriority = 1
	// MNetworkSerializer = "simulationTimeSerializer"
	// MNetworkSendProxyRecipientsFilter (UNKNOWN FOR PARSER)
	float32 m_flSimulationTime;
	// MNetworkEnable
	GameTime_t m_flCreateTime;
	// MNetworkEnable
	bool m_bClientSideRagdoll;
	// MNetworkEnable
	uint8 m_ubInterpolationFrame;
	Vector m_vPrevVPhysicsUpdatePos;
	// MNetworkEnable
	uint8 m_iTeamNum;
	CUtlSymbolLarge m_iGlobalname;
	int32 m_iSentToClients;
	// MNetworkEnable
	float32 m_flSpeed;
	CUtlString m_sUniqueHammerID;
	// MNetworkEnable
	uint32 m_spawnflags;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	GameTick_t m_nNextThinkTick;
	int32 m_nSimulationTick;
	CEntityIOOutput m_OnKilled;
	// MNetworkEnable
	// MNetworkPriority = 32
	// MNetworkUserGroup = "Player"
	uint32 m_fFlags;
	Vector m_vecAbsVelocity;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	// MNetworkPriority = 32
	CNetworkVelocityVector m_vecVelocity;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	Vector m_vecBaseVelocity;
	int32 m_nPushEnumCount;
	CCollisionProperty* m_pCollision;
	// MNetworkEnable
	CHandle< CBaseEntity > m_hEffectEntity;
	// MNetworkEnable
	// MNetworkPriority = 32
	CHandle< CBaseEntity > m_hOwnerEntity;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnEffectsChanged"
	uint32 m_fEffects;
	// MNetworkEnable
	// MNetworkPriority = 32
	// MNetworkUserGroup = "Player"
	CHandle< CBaseEntity > m_hGroundEntity;
	// MNetworkEnable
	// MNetworkPriority = 32
	// MNetworkUserGroup = "Player"
	int32 m_nGroundBodyIndex;
	// MNetworkEnable
	// MNetworkBitCount = 8
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 4.000000
	// MNetworkEncodeFlags = 1
	// MNetworkUserGroup = "LocalPlayerExclusive"
	float32 m_flFriction;
	// MNetworkEnable
	// MNetworkEncoder = "coord"
	float32 m_flElasticity;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	float32 m_flGravityScale;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	float32 m_flTimeScale;
	// MNetworkEnable
	// MNetworkUserGroup = "Water"
	// MNetworkBitCount = 8
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 1.000000
	// MNetworkEncodeFlags = 8
	float32 m_flWaterLevel;
	// MNetworkEnable
	bool m_bAnimatedEveryTick;
	bool m_bDisableLowViolence;
	uint8 m_nWaterType;
	int32 m_iEFlags;
	CEntityIOOutput m_OnUser1;
	CEntityIOOutput m_OnUser2;
	CEntityIOOutput m_OnUser3;
	CEntityIOOutput m_OnUser4;
	int32 m_iInitialTeamNum;
	// MNetworkEnable
	GameTime_t m_flNavIgnoreUntilTime;
	QAngle m_vecAngVelocity;
	bool m_bNetworkQuantizeOriginAndAngles;
	bool m_bLagCompensate;
	float32 m_flOverriddenFriction;
	CHandle< CBaseEntity > m_pBlocker;
	float32 m_flLocalTime;
	float32 m_flVPhysicsUpdateLocalTime;
	// MNetworkEnable
	BloodType m_nBloodType;
};
