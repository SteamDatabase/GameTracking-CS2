// MNetworkOutOfPVSUpdates (UNKNOWN FOR PARSER)
// MNetworkVarTypeOverride = "CCSPlayer_WeaponServices m_pWeaponServices"
// MNetworkIncludeByName = "m_pWeaponServices"
// MNetworkVarTypeOverride = "CCSPlayer_ItemServices m_pItemServices"
// MNetworkIncludeByName = "m_pItemServices"
// MNetworkVarTypeOverride = "CCSPlayer_UseServices m_pUseServices"
// MNetworkIncludeByName = "m_pUseServices"
// MNetworkVarTypeOverride = "CCSPlayer_WaterServices m_pWaterServices"
// MNetworkIncludeByName = "m_pWaterServices"
// MNetworkVarTypeOverride = "CCSPlayer_MovementServices m_pMovementServices"
// MNetworkIncludeByName = "m_pMovementServices"
// MNetworkVarTypeOverride = "CCSPlayer_CameraServices m_pCameraServices"
// MNetworkIncludeByName = "m_pCameraServices"
// MNetworkVarNames = "CCSPlayer_BulletServices * m_pBulletServices"
// MNetworkVarNames = "CCSPlayer_HostageServices * m_pHostageServices"
// MNetworkVarNames = "CCSPlayer_BuyServices * m_pBuyServices"
// MNetworkVarNames = "CCSPlayer_ActionTrackingServices * m_pActionTrackingServices"
// MNetworkVarNames = "bool m_bHasFemaleVoice"
// MNetworkVarNames = "char m_szLastPlaceName"
// MNetworkVarNames = "bool m_bInBuyZone"
// MNetworkVarNames = "bool m_bInHostageRescueZone"
// MNetworkVarNames = "bool m_bInBombZone"
// MNetworkVarNames = "int m_iRetakesOffering"
// MNetworkVarNames = "int m_iRetakesOfferingCard"
// MNetworkVarNames = "bool m_bRetakesHasDefuseKit"
// MNetworkVarNames = "bool m_bRetakesMVPLastRound"
// MNetworkVarNames = "int m_iRetakesMVPBoostItem"
// MNetworkVarNames = "loadout_slot_t m_RetakesMVPBoostExtraUtility"
// MNetworkVarNames = "GameTime_t m_flHealthShotBoostExpirationTime"
// MNetworkVarNames = "QAngle m_aimPunchAngle"
// MNetworkVarNames = "QAngle m_aimPunchAngleVel"
// MNetworkVarNames = "GameTick_t m_aimPunchTickBase"
// MNetworkVarNames = "float m_aimPunchTickFraction"
// MNetworkVarNames = "bool m_bIsBuyMenuOpen"
// MNetworkVarNames = "GameTime_t m_flTimeOfLastInjury"
// MNetworkVarNames = "GameTime_t m_flNextSprayDecalTime"
// MNetworkVarNames = "int m_nRagdollDamageBone"
// MNetworkVarNames = "Vector m_vRagdollDamageForce"
// MNetworkVarNames = "Vector m_vRagdollDamagePosition"
// MNetworkVarNames = "char m_szRagdollDamageWeaponName"
// MNetworkVarNames = "bool m_bRagdollDamageHeadshot"
// MNetworkVarNames = "Vector m_vRagdollServerOrigin"
// MNetworkVarNames = "CEconItemView m_EconGloves"
// MNetworkVarNames = "uint8 m_nEconGlovesChanged"
// MNetworkVarNames = "QAngle m_qDeathEyeAngles"
// MNetworkVarNames = "bool m_bLeftHanded"
// MNetworkVarNames = "GameTime_t m_fSwitchedHandednessTime"
// MNetworkVarNames = "float m_flViewmodelOffsetX"
// MNetworkVarNames = "float m_flViewmodelOffsetY"
// MNetworkVarNames = "float m_flViewmodelOffsetZ"
// MNetworkVarNames = "float m_flViewmodelFOV"
// MNetworkVarNames = "bool m_bIsWalking"
// MNetworkVarNames = "CEntityIndex m_nLastKillerIndex"
// MNetworkVarNames = "EntitySpottedState_t m_entitySpottedState"
// MNetworkVarNames = "bool m_bIsScoped"
// MNetworkVarNames = "bool m_bResumeZoom"
// MNetworkVarNames = "bool m_bIsDefusing"
// MNetworkVarNames = "bool m_bIsGrabbingHostage"
// MNetworkVarNames = "CSPlayerBlockingUseAction_t m_iBlockingUseActionInProgress"
// MNetworkVarNames = "GameTime_t m_flEmitSoundTime"
// MNetworkVarNames = "bool m_bInNoDefuseArea"
// MNetworkVarNames = "int m_nWhichBombZone"
// MNetworkVarNames = "int m_iShotsFired"
// MNetworkVarNames = "float m_flFlinchStack"
// MNetworkVarNames = "float m_flVelocityModifier"
// MNetworkVarNames = "float m_flHitHeading"
// MNetworkVarNames = "int m_nHitBodyPart"
// MNetworkVarNames = "bool m_bWaitForNoAttack"
// MNetworkVarNames = "bool m_bKilledByHeadshot"
// MNetworkVarNames = "QAngle m_thirdPersonHeading"
// MNetworkVarNames = "float m_flSlopeDropOffset"
// MNetworkVarNames = "float m_flSlopeDropHeight"
// MNetworkVarNames = "Vector m_vHeadConstraintOffset"
// MNetworkVarNames = "int32 m_ArmorValue"
// MNetworkVarNames = "uint16 m_unCurrentEquipmentValue"
// MNetworkVarNames = "uint16 m_unRoundStartEquipmentValue"
// MNetworkVarNames = "uint16 m_unFreezetimeEndEquipmentValue"
// MNetworkVarNames = "uint32 m_vecPlayerPatchEconIndices"
// MNetworkVarNames = "Color m_GunGameImmunityColor"
// MNetworkVarNames = "PredictedDamageTag_t m_PredictedDamageTags"
// MNetworkVarNames = "GameTime_t m_fImmuneToGunGameDamageTime"
// MNetworkVarNames = "bool m_bGunGameImmunity"
// MNetworkVarNames = "float m_fMolotovDamageTime"
// MNetworkVarNames = "QAngle m_angEyeAngles"
class CCSPlayerPawn : public CCSPlayerPawnBase
{
	// MNetworkEnable
	CCSPlayer_BulletServices* m_pBulletServices;
	// MNetworkEnable
	CCSPlayer_HostageServices* m_pHostageServices;
	// MNetworkEnable
	CCSPlayer_BuyServices* m_pBuyServices;
	// MNetworkEnable
	CCSPlayer_ActionTrackingServices* m_pActionTrackingServices;
	CCSPlayer_RadioServices* m_pRadioServices;
	CCSPlayer_DamageReactServices* m_pDamageReactServices;
	uint16 m_nCharacterDefIndex;
	// MNetworkEnable
	bool m_bHasFemaleVoice;
	CUtlString m_strVOPrefix;
	// MNetworkEnable
	char[18] m_szLastPlaceName;
	bool m_bInHostageResetZone;
	// MNetworkEnable
	bool m_bInBuyZone;
	CUtlVector< CHandle< CBaseEntity > > m_TouchingBuyZones;
	bool m_bWasInBuyZone;
	// MNetworkEnable
	bool m_bInHostageRescueZone;
	// MNetworkEnable
	bool m_bInBombZone;
	bool m_bWasInHostageRescueZone;
	// MNetworkEnable
	int32 m_iRetakesOffering;
	// MNetworkEnable
	int32 m_iRetakesOfferingCard;
	// MNetworkEnable
	bool m_bRetakesHasDefuseKit;
	// MNetworkEnable
	bool m_bRetakesMVPLastRound;
	// MNetworkEnable
	int32 m_iRetakesMVPBoostItem;
	// MNetworkEnable
	loadout_slot_t m_RetakesMVPBoostExtraUtility;
	// MNetworkEnable
	GameTime_t m_flHealthShotBoostExpirationTime;
	float32 m_flLandingTimeSeconds;
	// MNetworkEnable
	// MNetworkBitCount = 32
	QAngle m_aimPunchAngle;
	// MNetworkEnable
	// MNetworkBitCount = 32
	QAngle m_aimPunchAngleVel;
	// MNetworkEnable
	GameTick_t m_aimPunchTickBase;
	// MNetworkEnable
	float32 m_aimPunchTickFraction;
	CUtlVector< QAngle > m_aimPunchCache;
	// MNetworkEnable
	bool m_bIsBuyMenuOpen;
	GameTime_t m_lastLandTime;
	bool m_bOnGroundLastTick;
	int32 m_iPlayerLocked;
	// MNetworkEnable
	GameTime_t m_flTimeOfLastInjury;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	GameTime_t m_flNextSprayDecalTime;
	bool m_bNextSprayDecalTimeExpedited;
	// MNetworkEnable
	int32 m_nRagdollDamageBone;
	// MNetworkEnable
	Vector m_vRagdollDamageForce;
	// MNetworkEnable
	Vector m_vRagdollDamagePosition;
	// MNetworkEnable
	char[64] m_szRagdollDamageWeaponName;
	// MNetworkEnable
	bool m_bRagdollDamageHeadshot;
	// MNetworkEnable
	Vector m_vRagdollServerOrigin;
	// MNetworkEnable
	CEconItemView m_EconGloves;
	// MNetworkEnable
	uint8 m_nEconGlovesChanged;
	// MNetworkEnable
	QAngle m_qDeathEyeAngles;
	bool m_bSkipOneHeadConstraintUpdate;
	// MNetworkEnable
	bool m_bLeftHanded;
	// MNetworkEnable
	GameTime_t m_fSwitchedHandednessTime;
	// MNetworkEnable
	// MNetworkMinValue = -2.000000
	// MNetworkMaxValue = 2.500000
	float32 m_flViewmodelOffsetX;
	// MNetworkEnable
	// MNetworkMinValue = -2.000000
	// MNetworkMaxValue = 2.000000
	float32 m_flViewmodelOffsetY;
	// MNetworkEnable
	// MNetworkMinValue = -2.000000
	// MNetworkMaxValue = 2.000000
	float32 m_flViewmodelOffsetZ;
	// MNetworkEnable
	// MNetworkMinValue = 60.000000
	// MNetworkMaxValue = 68.000000
	float32 m_flViewmodelFOV;
	// MNetworkEnable
	bool m_bIsWalking;
	float32 m_fLastGivenDefuserTime;
	float32 m_fLastGivenBombTime;
	float32 m_flDealtDamageToEnemyMostRecentTimestamp;
	uint32 m_iDisplayHistoryBits;
	float32 m_flLastAttackedTeammate;
	GameTime_t m_allowAutoFollowTime;
	bool m_bResetArmorNextSpawn;
	// MNetworkEnable
	CEntityIndex m_nLastKillerIndex;
	// MNetworkEnable
	EntitySpottedState_t m_entitySpottedState;
	int32 m_nSpotRules;
	// MNetworkEnable
	bool m_bIsScoped;
	// MNetworkEnable
	bool m_bResumeZoom;
	// MNetworkEnable
	bool m_bIsDefusing;
	// MNetworkEnable
	bool m_bIsGrabbingHostage;
	// MNetworkEnable
	CSPlayerBlockingUseAction_t m_iBlockingUseActionInProgress;
	// MNetworkEnable
	GameTime_t m_flEmitSoundTime;
	// MNetworkEnable
	bool m_bInNoDefuseArea;
	CEntityIndex m_iBombSiteIndex;
	// MNetworkEnable
	int32 m_nWhichBombZone;
	bool m_bInBombZoneTrigger;
	bool m_bWasInBombZoneTrigger;
	// MNetworkEnable
	int32 m_iShotsFired;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	float32 m_flFlinchStack;
	// MNetworkEnable
	float32 m_flVelocityModifier;
	// MNetworkEnable
	float32 m_flHitHeading;
	// MNetworkEnable
	int32 m_nHitBodyPart;
	Vector m_vecTotalBulletForce;
	// MNetworkEnable
	bool m_bWaitForNoAttack;
	float32 m_ignoreLadderJumpTime;
	// MNetworkEnable
	bool m_bKilledByHeadshot;
	int32 m_LastHitBox;
	CCSBot* m_pBot;
	bool m_bBotAllowActive;
	// MNetworkEnable
	// MNetworkEncoder = "qangle_precise"
	// MNetworkPriority = 32
	QAngle m_thirdPersonHeading;
	// MNetworkEnable
	// MNetworkPriority = 32
	float32 m_flSlopeDropOffset;
	// MNetworkEnable
	// MNetworkPriority = 32
	float32 m_flSlopeDropHeight;
	// MNetworkEnable
	// MNetworkPriority = 32
	Vector m_vHeadConstraintOffset;
	int32 m_nLastPickupPriority;
	float32 m_flLastPickupPriorityTime;
	// MNetworkEnable
	int32 m_ArmorValue;
	// MNetworkEnable
	uint16 m_unCurrentEquipmentValue;
	// MNetworkEnable
	uint16 m_unRoundStartEquipmentValue;
	// MNetworkEnable
	uint16 m_unFreezetimeEndEquipmentValue;
	int32 m_iLastWeaponFireUsercmd;
	bool m_bIsSpawning;
	int32 m_iDeathFlags;
	bool m_bHasDeathInfo;
	float32 m_flDeathInfoTime;
	Vector m_vecDeathInfoOrigin;
	// MNetworkEnable
	uint32[5] m_vecPlayerPatchEconIndices;
	// MNetworkEnable
	Color m_GunGameImmunityColor;
	GameTime_t m_grenadeParameterStashTime;
	bool m_bGrenadeParametersStashed;
	QAngle m_angStashedShootAngles;
	Vector m_vecStashedGrenadeThrowPosition;
	Vector m_vecStashedVelocity;
	QAngle[2] m_angShootAngleHistory;
	Vector[2] m_vecThrowPositionHistory;
	Vector[2] m_vecVelocityHistory;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	CUtlVectorEmbeddedNetworkVar< PredictedDamageTag_t > m_PredictedDamageTags;
	int32 m_nHighestAppliedDamageTagTick;
	bool m_bCommittingSuicideOnTeamChange;
	bool m_wasNotKilledNaturally;
	// MNetworkEnable
	GameTime_t m_fImmuneToGunGameDamageTime;
	// MNetworkEnable
	bool m_bGunGameImmunity;
	// MNetworkEnable
	float32 m_fMolotovDamageTime;
	// MNetworkEnable
	// MNetworkEncoder = "qangle_precise"
	// MNetworkPriority = 32
	QAngle m_angEyeAngles;
};
