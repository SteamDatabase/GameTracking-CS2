// MNetworkExcludeByName = "m_bClientSideRagdoll"
// MNetworkExcludeByName = "m_iMaxHealth"
// MNetworkExcludeByUserGroup = "Player"
// MNetworkExcludeByUserGroup = "Water"
// MNetworkExcludeByUserGroup = "LocalPlayerExclusive"
// MNetworkExcludeByName = "m_spawnflags"
// MNetworkExcludeByName = "m_bTakesDamage"
// MNetworkExcludeByName = "m_nTakeDamageFlags"
// MNetworkExcludeByName = "m_vecAbsVelocity"
// MNetworkExcludeByName = "m_flSpeed"
// MNetworkVarNames = "CBodyComponent::Storage_t m_CBodyComponent"
// MNetworkVarNames = "int32 m_iMaxHealth"
// MNetworkVarNames = "int32 m_iHealth"
// MNetworkVarNames = "uint8 m_lifeState"
// MNetworkVarNames = "bool m_bTakesDamage"
// MNetworkVarNames = "TakeDamageFlags_t m_nTakeDamageFlags"
// MNetworkVarNames = "EntityPlatformTypes_t m_nPlatformType"
// MNetworkVarNames = "uint8 m_ubInterpolationFrame"
// MNetworkVarNames = "EntitySubclassID_t m_nSubclassID"
// MNetworkVarNames = "float32 m_flAnimTime"
// MNetworkVarNames = "float32 m_flSimulationTime"
// MNetworkVarNames = "GameTime_t m_flCreateTime"
// MNetworkVarNames = "float m_flSpeed"
// MNetworkVarNames = "bool m_bClientSideRagdoll"
// MNetworkVarNames = "uint8 m_iTeamNum"
// MNetworkVarNames = "uint32 m_spawnflags"
// MNetworkVarNames = "GameTick_t m_nNextThinkTick"
// MNetworkVarNames = "uint32 m_fFlags"
// MNetworkVarNames = "Vector m_vecBaseVelocity"
// MNetworkVarNames = "CHandle< CBaseEntity> m_hEffectEntity"
// MNetworkVarNames = "CHandle< CBaseEntity> m_hOwnerEntity"
// MNetworkVarNames = "MoveCollide_t m_MoveCollide"
// MNetworkVarNames = "MoveType_t m_MoveType"
// MNetworkVarNames = "float32 m_flWaterLevel"
// MNetworkVarNames = "uint32 m_fEffects"
// MNetworkVarNames = "CHandle< CBaseEntity> m_hGroundEntity"
// MNetworkVarNames = "int m_nGroundBodyIndex"
// MNetworkVarNames = "float32 m_flFriction"
// MNetworkVarNames = "float32 m_flElasticity"
// MNetworkVarNames = "float32 m_flGravityScale"
// MNetworkVarNames = "float32 m_flTimeScale"
// MNetworkVarNames = "bool m_bAnimatedEveryTick"
// MNetworkVarNames = "bool m_bGravityDisabled"
// MNetworkVarNames = "GameTime_t m_flNavIgnoreUntilTime"
// MNetworkVarNames = "BloodType m_nBloodType"
class C_BaseEntity : public CEntityInstance
{
	// MNetworkEnable
	// MNetworkUserGroup = "CBodyComponent"
	// MNetworkAlias = "CBodyComponent"
	// MNetworkTypeAlias = "CBodyComponent"
	// MNetworkPriority = 48
	CBodyComponent* m_CBodyComponent;
	CNetworkTransmitComponent m_NetworkTransmitComponent;
	GameTick_t m_nLastThinkTick;
	CGameSceneNode* m_pGameSceneNode;
	CRenderComponent* m_pRenderComponent;
	CCollisionProperty* m_pCollision;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	int32 m_iMaxHealth;
	// MNetworkEnable
	// MNetworkSerializer = "ClampHealth"
	// MNetworkUserGroup = "Player"
	// MNetworkPriority = 32
	int32 m_iHealth;
	float32 m_flDamageAccumulator;
	// MNetworkEnable
	// MNetworkUserGroup = "Player"
	// MNetworkPriority = 32
	uint8 m_lifeState;
	// MNetworkEnable
	bool m_bTakesDamage;
	// MNetworkEnable
	TakeDamageFlags_t m_nTakeDamageFlags;
	// MNetworkEnable
	EntityPlatformTypes_t m_nPlatformType;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnInterpolationFrameChanged"
	uint8 m_ubInterpolationFrame;
	CHandle< C_BaseEntity > m_hSceneObjectController;
	int32 m_nNoInterpolationTick;
	int32 m_nVisibilityNoInterpolationTick;
	float32 m_flProxyRandomValue;
	int32 m_iEFlags;
	uint8 m_nWaterType;
	bool m_bInterpolateEvenWithNoModel;
	bool m_bPredictionEligible;
	bool m_bApplyLayerMatchIDToModel;
	CUtlStringToken m_tokLayerMatchID;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnSubclassIDChanged"
	CUtlStringToken m_nSubclassID;
	int32 m_nSimulationTick;
	int32 m_iCurrentThinkContext;
	CUtlVector< thinkfunc_t > m_aThinkFunctions;
	bool m_bDisabledContextThinks;
	// MNetworkEnable
	// MNetworkPriority = 0
	// MNetworkSerializer = "animTimeSerializer"
	float32 m_flAnimTime;
	// MNetworkEnable
	// MNetworkPriority = 1
	// MNetworkSerializer = "simulationTimeSerializer"
	// MNetworkChangeCallback = "OnSimulationTimeChanged"
	float32 m_flSimulationTime;
	uint8 m_nSceneObjectOverrideFlags;
	bool m_bHasSuccessfullyInterpolated;
	bool m_bHasAddedVarsToInterpolation;
	bool m_bRenderEvenWhenNotSuccessfullyInterpolated;
	int32[2] m_nInterpolationLatchDirtyFlags;
	uint16[11] m_ListEntry;
	// MNetworkEnable
	GameTime_t m_flCreateTime;
	// MNetworkEnable
	float32 m_flSpeed;
	uint16 m_EntClientFlags;
	// MNetworkEnable
	bool m_bClientSideRagdoll;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnNetVarTeamNumChanged"
	uint8 m_iTeamNum;
	// MNetworkEnable
	uint32 m_spawnflags;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	GameTick_t m_nNextThinkTick;
	// MNetworkEnable
	// MNetworkPriority = 32
	// MNetworkUserGroup = "Player"
	// MNetworkChangeCallback = "OnFlagsChanged"
	uint32 m_fFlags;
	Vector m_vecAbsVelocity;
	// MNetworkEnable
	// MNetworkAlias = "m_vecVelocity"
	// MNetworkUserGroup = "LocalPlayerExclusive"
	// MNetworkChangeCallback = "OnServerVelocityChanged"
	// MNetworkPriority = 32
	CNetworkVelocityVector m_vecServerVelocity;
	CNetworkVelocityVector m_vecVelocity;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	Vector m_vecBaseVelocity;
	// MNetworkEnable
	CHandle< C_BaseEntity > m_hEffectEntity;
	// MNetworkEnable
	// MNetworkPriority = 32
	CHandle< C_BaseEntity > m_hOwnerEntity;
	// MNetworkEnable
	MoveCollide_t m_MoveCollide;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnMoveTypeChanged"
	MoveType_t m_MoveType;
	MoveType_t m_nActualMoveType;
	// MNetworkEnable
	// MNetworkUserGroup = "Water"
	// MNetworkChangeCallback = "OnWaterLevelChangeNetworked"
	// MNetworkBitCount = 8
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 1.000000
	// MNetworkEncodeFlags = 8
	float32 m_flWaterLevel;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnEffectsChanged"
	uint32 m_fEffects;
	// MNetworkEnable
	// MNetworkPriority = 32
	// MNetworkUserGroup = "Player"
	CHandle< C_BaseEntity > m_hGroundEntity;
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
	// MNetworkChangeCallback = "OnGravityUpdated"
	float32 m_flGravityScale;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	float32 m_flTimeScale;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnInterpolationAmountChanged"
	bool m_bAnimatedEveryTick;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnGravityUpdated"
	bool m_bGravityDisabled;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnNavIgnoreChanged"
	GameTime_t m_flNavIgnoreUntilTime;
	uint16 m_hThink;
	uint8 m_fBBoxVisFlags;
	float32 m_flActualGravityScale;
	bool m_bGravityActuallyDisabled;
	bool m_bPredictable;
	bool m_bRenderWithViewModels;
	int32 m_nFirstPredictableCommand;
	int32 m_nLastPredictableCommand;
	CHandle< C_BaseEntity > m_hOldMoveParent;
	CParticleProperty m_Particles;
	QAngle m_vecAngVelocity;
	int32 m_DataChangeEventRef;
	CUtlVector< CEntityHandle > m_dependencies;
	int32 m_nCreationTick;
	bool m_bAnimTimeChanged;
	bool m_bSimulationTimeChanged;
	CUtlString m_sUniqueHammerID;
	// MNetworkEnable
	BloodType m_nBloodType;
};
