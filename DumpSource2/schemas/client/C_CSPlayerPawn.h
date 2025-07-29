// MNetworkVarNames = "CCSPlayer_BulletServices * m_pBulletServices"
// MNetworkVarNames = "CCSPlayer_HostageServices * m_pHostageServices"
// MNetworkVarNames = "CCSPlayer_BuyServices * m_pBuyServices"
// MNetworkVarNames = "CCSPlayer_GlowServices * m_pGlowServices"
// MNetworkVarNames = "CCSPlayer_ActionTrackingServices * m_pActionTrackingServices"
// MNetworkVarTypeOverride = "CCSPlayer_UseServices m_pUseServices"
// MNetworkIncludeByName = "m_pUseServices"
// MNetworkVarTypeOverride = "CCSPlayer_ItemServices m_pItemServices"
// MNetworkIncludeByName = "m_pItemServices"
// MNetworkVarTypeOverride = "CCSPlayer_MovementServices m_pMovementServices"
// MNetworkIncludeByName = "m_pMovementServices"
// MNetworkVarTypeOverride = "CCSPlayer_WaterServices m_pWaterServices"
// MNetworkIncludeByName = "m_pWaterServices"
// MNetworkVarTypeOverride = "CCSPlayer_CameraServices m_pCameraServices"
// MNetworkIncludeByName = "m_pCameraServices"
// MNetworkVarTypeOverride = "CCSPlayer_WeaponServices m_pWeaponServices"
// MNetworkIncludeByName = "m_pWeaponServices"
// MNetworkIncludeByName = "m_ArmorValue"
// MNetworkVarNames = "GameTime_t m_flHealthShotBoostExpirationTime"
// MNetworkVarNames = "bool m_bHasFemaleVoice"
// MNetworkVarNames = "char m_szLastPlaceName"
// MNetworkVarNames = "bool m_bInBuyZone"
// MNetworkVarNames = "QAngle m_aimPunchAngle"
// MNetworkVarNames = "QAngle m_aimPunchAngleVel"
// MNetworkVarNames = "int m_aimPunchTickBase"
// MNetworkVarNames = "float m_aimPunchTickFraction"
// MNetworkVarNames = "bool m_bInHostageRescueZone"
// MNetworkVarNames = "bool m_bInBombZone"
// MNetworkVarNames = "bool m_bIsBuyMenuOpen"
// MNetworkVarNames = "GameTime_t m_flTimeOfLastInjury"
// MNetworkVarNames = "GameTime_t m_flNextSprayDecalTime"
// MNetworkVarNames = "int m_iRetakesOffering"
// MNetworkVarNames = "int m_iRetakesOfferingCard"
// MNetworkVarNames = "bool m_bRetakesHasDefuseKit"
// MNetworkVarNames = "bool m_bRetakesMVPLastRound"
// MNetworkVarNames = "int m_iRetakesMVPBoostItem"
// MNetworkVarNames = "loadout_slot_t m_RetakesMVPBoostExtraUtility"
// MNetworkVarNames = "CEconItemView m_EconGloves"
// MNetworkVarNames = "uint8 m_nEconGlovesChanged"
// MNetworkVarNames = "int m_nRagdollDamageBone"
// MNetworkVarNames = "Vector m_vRagdollDamageForce"
// MNetworkVarNames = "Vector m_vRagdollDamagePosition"
// MNetworkVarNames = "char m_szRagdollDamageWeaponName"
// MNetworkVarNames = "bool m_bRagdollDamageHeadshot"
// MNetworkVarNames = "Vector m_vRagdollServerOrigin"
// MNetworkReplayCompatField = "m_bClientRagdoll"
// MNetworkVarNames = "QAngle m_qDeathEyeAngles"
// MNetworkVarNames = "bool m_bLeftHanded"
// MNetworkVarNames = "GameTime_t m_fSwitchedHandednessTime"
// MNetworkVarNames = "float m_flViewmodelOffsetX"
// MNetworkVarNames = "float m_flViewmodelOffsetY"
// MNetworkVarNames = "float m_flViewmodelOffsetZ"
// MNetworkVarNames = "float m_flViewmodelFOV"
// MNetworkVarNames = "uint32 m_vecPlayerPatchEconIndices"
// MNetworkVarNames = "Color m_GunGameImmunityColor"
// MNetworkVarNames = "bool m_bIsWalking"
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
// MNetworkVarNames = "int32 m_ArmorValue"
// MNetworkVarNames = "uint16 m_unCurrentEquipmentValue"
// MNetworkVarNames = "uint16 m_unRoundStartEquipmentValue"
// MNetworkVarNames = "uint16 m_unFreezetimeEndEquipmentValue"
// MNetworkVarNames = "CEntityIndex m_nLastKillerIndex"
// MNetworkVarNames = "PredictedDamageTag_t m_PredictedDamageTags"
// MNetworkVarNames = "GameTime_t m_fImmuneToGunGameDamageTime"
// MNetworkVarNames = "bool m_bGunGameImmunity"
// MNetworkVarNames = "float m_fMolotovDamageTime"
class C_CSPlayerPawn : public C_CSPlayerPawnBase
{
	// MNetworkEnable
	CCSPlayer_BulletServices* m_pBulletServices;
	// MNetworkEnable
	CCSPlayer_HostageServices* m_pHostageServices;
	// MNetworkEnable
	CCSPlayer_BuyServices* m_pBuyServices;
	// MNetworkEnable
	CCSPlayer_GlowServices* m_pGlowServices;
	// MNetworkEnable
	CCSPlayer_ActionTrackingServices* m_pActionTrackingServices;
	CCSPlayer_DamageReactServices* m_pDamageReactServices;
	// MNetworkEnable
	GameTime_t m_flHealthShotBoostExpirationTime;
	GameTime_t m_flLastFiredWeaponTime;
	// MNetworkEnable
	bool m_bHasFemaleVoice;
	float32 m_flLandingTimeSeconds;
	float32 m_flOldFallVelocity;
	// MNetworkEnable
	char[18] m_szLastPlaceName;
	bool m_bPrevDefuser;
	bool m_bPrevHelmet;
	int32 m_nPrevArmorVal;
	int32 m_nPrevGrenadeAmmoCount;
	uint32 m_unPreviousWeaponHash;
	uint32 m_unWeaponHash;
	// MNetworkEnable
	bool m_bInBuyZone;
	bool m_bPreviouslyInBuyZone;
	// MNetworkEnable
	// MNetworkBitCount = 32
	QAngle m_aimPunchAngle;
	// MNetworkEnable
	// MNetworkBitCount = 32
	QAngle m_aimPunchAngleVel;
	// MNetworkEnable
	int32 m_aimPunchTickBase;
	// MNetworkEnable
	float32 m_aimPunchTickFraction;
	CUtlVector< QAngle > m_aimPunchCache;
	bool m_bInLanding;
	float32 m_flLandingStartTime;
	// MNetworkEnable
	bool m_bInHostageRescueZone;
	// MNetworkEnable
	bool m_bInBombZone;
	// MNetworkEnable
	bool m_bIsBuyMenuOpen;
	// MNetworkEnable
	GameTime_t m_flTimeOfLastInjury;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	GameTime_t m_flNextSprayDecalTime;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnRetakesOfferingChanged"
	int32 m_iRetakesOffering;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnRetakesOfferingCardChanged"
	int32 m_iRetakesOfferingCard;
	// MNetworkEnable
	bool m_bRetakesHasDefuseKit;
	// MNetworkEnable
	bool m_bRetakesMVPLastRound;
	// MNetworkEnable
	int32 m_iRetakesMVPBoostItem;
	// MNetworkEnable
	loadout_slot_t m_RetakesMVPBoostExtraUtility;
	bool m_bNeedToReApplyGloves;
	// MNetworkEnable
	C_EconItemView m_EconGloves;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnEconGlovesChanged"
	uint8 m_nEconGlovesChanged;
	bool m_bMustSyncRagdollState;
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
	bool m_bLastHeadBoneTransformIsValid;
	GameTime_t m_lastLandTime;
	bool m_bOnGroundLastTick;
	CHandle< C_CS2HudModelArms > m_hHudModelArms;
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
	// MNetworkChangeCallback = "RecvProxy_PatchEconIndices"
	uint32[5] m_vecPlayerPatchEconIndices;
	// MNetworkEnable
	Color m_GunGameImmunityColor;
	CUtlVector< C_BulletHitModel* > m_vecBulletHitModels;
	// MNetworkEnable
	bool m_bIsWalking;
	// MNetworkEnable
	// MNetworkEncoder = "qangle_precise"
	// MNetworkChangeCallback = "OnThirdPersonHeadingChanged"
	// MNetworkPriority = 32
	QAngle m_thirdPersonHeading;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnSlopeDropOffsetChanged"
	// MNetworkPriority = 32
	float32 m_flSlopeDropOffset;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnSlopeDropHeightChanged"
	// MNetworkPriority = 32
	float32 m_flSlopeDropHeight;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnHeadConstraintChanged"
	// MNetworkPriority = 32
	Vector m_vHeadConstraintOffset;
	// MNetworkEnable
	EntitySpottedState_t m_entitySpottedState;
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
	// MNetworkEnable
	int32 m_nWhichBombZone;
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
	// MNetworkEnable
	bool m_bWaitForNoAttack;
	float32 m_ignoreLadderJumpTime;
	// MNetworkEnable
	bool m_bKilledByHeadshot;
	// MNetworkEnable
	int32 m_ArmorValue;
	// MNetworkEnable
	uint16 m_unCurrentEquipmentValue;
	// MNetworkEnable
	uint16 m_unRoundStartEquipmentValue;
	// MNetworkEnable
	uint16 m_unFreezetimeEndEquipmentValue;
	// MNetworkEnable
	CEntityIndex m_nLastKillerIndex;
	bool m_bOldIsScoped;
	bool m_bHasDeathInfo;
	float32 m_flDeathInfoTime;
	Vector m_vecDeathInfoOrigin;
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
	// MNetworkChangeCallback = "OnPredictedDamageTagsChanged"
	C_UtlVectorEmbeddedNetworkVar< PredictedDamageTag_t > m_PredictedDamageTags;
	GameTick_t m_nPrevHighestReceivedDamageTagTick;
	int32 m_nHighestAppliedDamageTagTick;
	bool m_bShouldAutobuyDMWeapons;
	// MNetworkEnable
	GameTime_t m_fImmuneToGunGameDamageTime;
	// MNetworkEnable
	bool m_bGunGameImmunity;
	GameTime_t m_fImmuneToGunGameDamageTimeLast;
	// MNetworkEnable
	float32 m_fMolotovDamageTime;
};
