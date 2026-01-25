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
// MNetworkExcludeByName = "m_flWaterLevel"
// MNetworkExcludeByName = "m_flTimeScale"
// MNetworkExcludeByName = "m_vecBaseVelocity"
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
	// MNotSaved
	CNetworkTransmitComponent m_NetworkTransmitComponent;
	// MNotSaved
	GameTick_t m_nLastThinkTick;
	// MNotSaved
	CGameSceneNode* m_pGameSceneNode;
	// MNotSaved
	CRenderComponent* m_pRenderComponent;
	// MNotSaved
	CCollisionProperty* m_pCollision;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	// MNotSaved
	int32 m_iMaxHealth;
	// MNetworkEnable
	// MNetworkSerializer = "ClampHealth"
	// MNetworkUserGroup = "Player"
	// MNetworkPriority = 32
	int32 m_iHealth;
	// MNotSaved
	float32 m_flDamageAccumulator;
	// MNetworkEnable
	// MNetworkUserGroup = "Player"
	// MNetworkPriority = 32
	// MNotSaved
	uint8 m_lifeState;
	// MNetworkEnable
	// MNotSaved
	bool m_bTakesDamage;
	// MNetworkEnable
	// MNotSaved
	TakeDamageFlags_t m_nTakeDamageFlags;
	// MNetworkEnable
	EntityPlatformTypes_t m_nPlatformType;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnInterpolationFrameChanged"
	// MNotSaved
	uint8 m_ubInterpolationFrame;
	CHandle< C_BaseEntity > m_hSceneObjectController;
	// MNotSaved
	int32 m_nNoInterpolationTick;
	// MNotSaved
	int32 m_nVisibilityNoInterpolationTick;
	// MNotSaved
	float32 m_flProxyRandomValue;
	// MNotSaved
	int32 m_iEFlags;
	// MNotSaved
	uint8 m_nWaterType;
	// MNotSaved
	bool m_bInterpolateEvenWithNoModel;
	// MNotSaved
	bool m_bPredictionEligible;
	// MNotSaved
	bool m_bApplyLayerMatchIDToModel;
	// MNotSaved
	CUtlStringToken m_tokLayerMatchID;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnSubclassIDChanged"
	CUtlStringToken m_nSubclassID;
	// MNotSaved
	int32 m_nSimulationTick;
	// MNotSaved
	int32 m_iCurrentThinkContext;
	// MNotSaved
	CUtlVector< thinkfunc_t > m_aThinkFunctions;
	bool m_bDisabledContextThinks;
	// MNetworkEnable
	// MNetworkPriority = 0
	// MNetworkSerializer = "animTimeSerializer"
	// MNotSaved
	float32 m_flAnimTime;
	// MNetworkEnable
	// MNetworkPriority = 1
	// MNetworkSerializer = "simulationTimeSerializer"
	// MNetworkChangeCallback = "OnSimulationTimeChanged"
	// MNotSaved
	float32 m_flSimulationTime;
	uint8 m_nSceneObjectOverrideFlags;
	// MNotSaved
	bool m_bHasSuccessfullyInterpolated;
	// MNotSaved
	bool m_bHasAddedVarsToInterpolation;
	// MNotSaved
	bool m_bRenderEvenWhenNotSuccessfullyInterpolated;
	// MNotSaved
	int32[2] m_nInterpolationLatchDirtyFlags;
	// MNotSaved
	uint16[11] m_ListEntry;
	// MNetworkEnable
	// MNotSaved
	GameTime_t m_flCreateTime;
	// MNetworkEnable
	// MNotSaved
	float32 m_flSpeed;
	// MNotSaved
	uint16 m_EntClientFlags;
	// MNetworkEnable
	// MNotSaved
	bool m_bClientSideRagdoll;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnNetVarTeamNumChanged"
	// MNotSaved
	uint8 m_iTeamNum;
	// MNetworkEnable
	uint32 m_spawnflags;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	// MNotSaved
	GameTick_t m_nNextThinkTick;
	// MNetworkEnable
	// MNetworkPriority = 32
	// MNetworkUserGroup = "Player"
	// MNetworkChangeCallback = "OnFlagsChanged"
	uint32 m_fFlags;
	// MNotSaved
	Vector m_vecAbsVelocity;
	// MNetworkEnable
	// MNetworkAlias = "m_vecVelocity"
	// MNetworkUserGroup = "LocalPlayerExclusive"
	// MNetworkChangeCallback = "OnServerVelocityChanged"
	// MNetworkPriority = 32
	// MNotSaved
	CNetworkVelocityVector m_vecServerVelocity;
	CNetworkVelocityVector m_vecVelocity;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	// MNotSaved
	Vector m_vecBaseVelocity;
	// MNetworkEnable
	// MNotSaved
	CHandle< C_BaseEntity > m_hEffectEntity;
	// MNetworkEnable
	// MNetworkPriority = 32
	CHandle< C_BaseEntity > m_hOwnerEntity;
	// MNetworkEnable
	// MNotSaved
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
	// MNotSaved
	float32 m_flWaterLevel;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnEffectsChanged"
	// MNotSaved
	uint32 m_fEffects;
	// MNetworkEnable
	// MNetworkPriority = 32
	// MNetworkUserGroup = "Player"
	// MNotSaved
	CHandle< C_BaseEntity > m_hGroundEntity;
	// MNetworkEnable
	// MNetworkPriority = 32
	// MNetworkUserGroup = "Player"
	// MNotSaved
	int32 m_nGroundBodyIndex;
	// MNetworkEnable
	// MNetworkBitCount = 8
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 4.000000
	// MNetworkEncodeFlags = 1
	// MNetworkUserGroup = "LocalPlayerExclusive"
	// MNotSaved
	float32 m_flFriction;
	// MNetworkEnable
	// MNetworkEncoder = "coord"
	// MNotSaved
	float32 m_flElasticity;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnGravityUpdated"
	// MNotSaved
	float32 m_flGravityScale;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	// MNotSaved
	float32 m_flTimeScale;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnInterpolationAmountChanged"
	// MNotSaved
	bool m_bAnimatedEveryTick;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnGravityUpdated"
	bool m_bGravityDisabled;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnNavIgnoreChanged"
	// MNotSaved
	GameTime_t m_flNavIgnoreUntilTime;
	// MNotSaved
	uint16 m_hThink;
	// MNotSaved
	uint8 m_fBBoxVisFlags;
	float32 m_flActualGravityScale;
	bool m_bGravityActuallyDisabled;
	// MNotSaved
	bool m_bPredictable;
	bool m_bRenderWithViewModels;
	// MNotSaved
	int32 m_nFirstPredictableCommand;
	// MNotSaved
	int32 m_nLastPredictableCommand;
	// MNotSaved
	CHandle< C_BaseEntity > m_hOldMoveParent;
	// MNotSaved
	CParticleProperty m_Particles;
	QAngle m_vecAngVelocity;
	// MNotSaved
	int32 m_DataChangeEventRef;
	// MNotSaved
	CUtlVector< CEntityHandle > m_dependencies;
	// MNotSaved
	int32 m_nCreationTick;
	// MNotSaved
	bool m_bAnimTimeChanged;
	// MNotSaved
	bool m_bSimulationTimeChanged;
	// MNotSaved
	CUtlString m_sUniqueHammerID;
	// MNetworkEnable
	BloodType m_nBloodType;
};
