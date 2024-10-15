class C_CSPlayerPawn : public C_CSPlayerPawnBase
{
	CCSPlayer_BulletServices* m_pBulletServices;
	CCSPlayer_HostageServices* m_pHostageServices;
	CCSPlayer_BuyServices* m_pBuyServices;
	CCSPlayer_GlowServices* m_pGlowServices;
	CCSPlayer_ActionTrackingServices* m_pActionTrackingServices;
	CCSPlayer_DamageReactServices* m_pDamageReactServices;
	GameTime_t m_flHealthShotBoostExpirationTime;
	GameTime_t m_flLastFiredWeaponTime;
	bool m_bHasFemaleVoice;
	float32 m_flLandingTimeSeconds;
	float32 m_flOldFallVelocity;
	char[18] m_szLastPlaceName;
	bool m_bPrevDefuser;
	bool m_bPrevHelmet;
	int32 m_nPrevArmorVal;
	int32 m_nPrevGrenadeAmmoCount;
	uint32 m_unPreviousWeaponHash;
	uint32 m_unWeaponHash;
	bool m_bInBuyZone;
	bool m_bPreviouslyInBuyZone;
	QAngle m_aimPunchAngle;
	QAngle m_aimPunchAngleVel;
	int32 m_aimPunchTickBase;
	float32 m_aimPunchTickFraction;
	CUtlVector< QAngle > m_aimPunchCache;
	bool m_bInLanding;
	float32 m_flLandingStartTime;
	bool m_bInHostageRescueZone;
	bool m_bInBombZone;
	bool m_bIsBuyMenuOpen;
	GameTime_t m_flTimeOfLastInjury;
	GameTime_t m_flNextSprayDecalTime;
	int32 m_iRetakesOffering;
	int32 m_iRetakesOfferingCard;
	bool m_bRetakesHasDefuseKit;
	bool m_bRetakesMVPLastRound;
	int32 m_iRetakesMVPBoostItem;
	loadout_slot_t m_RetakesMVPBoostExtraUtility;
	bool m_bNeedToReApplyGloves;
	C_EconItemView m_EconGloves;
	uint8 m_nEconGlovesChanged;
	bool m_bMustSyncRagdollState;
	int32 m_nRagdollDamageBone;
	Vector m_vRagdollDamageForce;
	Vector m_vRagdollDamagePosition;
	char[64] m_szRagdollDamageWeaponName;
	bool m_bRagdollDamageHeadshot;
	Vector m_vRagdollServerOrigin;
	bool m_bLastHeadBoneTransformIsValid;
	GameTime_t m_lastLandTime;
	bool m_bOnGroundLastTick;
	QAngle m_qDeathEyeAngles;
	bool m_bSkipOneHeadConstraintUpdate;
	bool m_bLeftHanded;
	GameTime_t m_fSwitchedHandednessTime;
	float32 m_flViewmodelOffsetX;
	float32 m_flViewmodelOffsetY;
	float32 m_flViewmodelOffsetZ;
	float32 m_flViewmodelFOV;
	uint32[5] m_vecPlayerPatchEconIndices;
	Color m_GunGameImmunityColor;
	CUtlVector< C_BulletHitModel* > m_vecBulletHitModels;
	bool m_bIsWalking;
	QAngle m_thirdPersonHeading;
	float32 m_flSlopeDropOffset;
	float32 m_flSlopeDropHeight;
	Vector m_vHeadConstraintOffset;
	EntitySpottedState_t m_entitySpottedState;
	bool m_bIsScoped;
	bool m_bResumeZoom;
	bool m_bIsDefusing;
	bool m_bIsGrabbingHostage;
	CSPlayerBlockingUseAction_t m_iBlockingUseActionInProgress;
	GameTime_t m_flEmitSoundTime;
	bool m_bInNoDefuseArea;
	int32 m_nWhichBombZone;
	int32 m_iShotsFired;
	float32 m_flFlinchStack;
	float32 m_flVelocityModifier;
	float32 m_flHitHeading;
	int32 m_nHitBodyPart;
	bool m_bWaitForNoAttack;
	float32 m_ignoreLadderJumpTime;
	bool m_bKilledByHeadshot;
	int32 m_ArmorValue;
	uint16 m_unCurrentEquipmentValue;
	uint16 m_unRoundStartEquipmentValue;
	uint16 m_unFreezetimeEndEquipmentValue;
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
	C_UtlVectorEmbeddedNetworkVar< PredictedDamageTag_t > m_PredictedDamageTags;
	GameTick_t m_nPrevHighestReceivedDamageTagTick;
	int32 m_nHighestAppliedDamageTagTick;
};