// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MPropertySuppressBaseClassField = "m_iSlot"
// MPropertySuppressBaseClassField = "m_iPosition"
class CCSWeaponBaseVData : public CBasePlayerWeaponVData
{
	CSWeaponType m_WeaponType;
	CSWeaponCategory m_WeaponCategory;
	// MPropertyStartGroup = "Visuals"
	CResourceNameTyped< CWeakHandle< InfoForResourceTypeCModel > > m_szViewModel;
	CResourceNameTyped< CWeakHandle< InfoForResourceTypeCModel > > m_szPlayerModel;
	CResourceNameTyped< CWeakHandle< InfoForResourceTypeCModel > > m_szWorldDroppedModel;
	CResourceNameTyped< CWeakHandle< InfoForResourceTypeCModel > > m_szAimsightLensMaskModel;
	CResourceNameTyped< CWeakHandle< InfoForResourceTypeCModel > > m_szMagazineModel;
	CResourceNameTyped< CWeakHandle< InfoForResourceTypeIParticleSystemDefinition > > m_szHeatEffect;
	CResourceNameTyped< CWeakHandle< InfoForResourceTypeIParticleSystemDefinition > > m_szEjectBrassEffect;
	CResourceNameTyped< CWeakHandle< InfoForResourceTypeIParticleSystemDefinition > > m_szMuzzleFlashParticleAlt;
	CResourceNameTyped< CWeakHandle< InfoForResourceTypeIParticleSystemDefinition > > m_szMuzzleFlashThirdPersonParticle;
	CResourceNameTyped< CWeakHandle< InfoForResourceTypeIParticleSystemDefinition > > m_szMuzzleFlashThirdPersonParticleAlt;
	// MPropertyDescription = "Effect to actually fire into the world from this weapon"
	CResourceNameTyped< CWeakHandle< InfoForResourceTypeIParticleSystemDefinition > > m_szTracerParticle;
	// MPropertyStartGroup = "HUD Positions"
	// MPropertyFriendlyName = "HUD Bucket"
	// MPropertyDescription = "Which 'column' to display this weapon in the HUD"
	gear_slot_t m_GearSlot;
	int32 m_GearSlotPosition;
	// MPropertyFriendlyName = "HUD Bucket Position"
	// MPropertyDescription = "Default team (non Terrorist or Counter-Terrorist) 'row' to display this weapon in the HUD."
	loadout_slot_t m_DefaultLoadoutSlot;
	CUtlString m_sWrongTeamMsg;
	// MPropertyStartGroup = "In-Game Data"
	int32 m_nPrice;
	int32 m_nKillAward;
	int32 m_nPrimaryReserveAmmoMax;
	int32 m_nSecondaryReserveAmmoMax;
	bool m_bMeleeWeapon;
	bool m_bHasBurstMode;
	bool m_bIsRevolver;
	bool m_bCannotShootUnderwater;
	// MPropertyFriendlyName = "In-Code weapon name"
	CGlobalSymbol m_szName;
	// MPropertyFriendlyName = "Player Animation Extension"
	CUtlString m_szAnimExtension;
	CSWeaponSilencerType m_eSilencerType;
	int32 m_nCrosshairMinDistance;
	int32 m_nCrosshairDeltaDistance;
	bool m_bIsFullAuto;
	int32 m_nNumBullets;
	// MPropertyStartGroup = "Firing Mode Data"
	CFiringModeFloat m_flCycleTime;
	CFiringModeFloat m_flMaxSpeed;
	CFiringModeFloat m_flSpread;
	CFiringModeFloat m_flInaccuracyCrouch;
	CFiringModeFloat m_flInaccuracyStand;
	CFiringModeFloat m_flInaccuracyJump;
	CFiringModeFloat m_flInaccuracyLand;
	CFiringModeFloat m_flInaccuracyLadder;
	CFiringModeFloat m_flInaccuracyFire;
	CFiringModeFloat m_flInaccuracyMove;
	CFiringModeFloat m_flRecoilAngle;
	CFiringModeFloat m_flRecoilAngleVariance;
	CFiringModeFloat m_flRecoilMagnitude;
	CFiringModeFloat m_flRecoilMagnitudeVariance;
	CFiringModeInt m_nTracerFrequency;
	float32 m_flInaccuracyJumpInitial;
	float32 m_flInaccuracyJumpApex;
	float32 m_flInaccuracyReload;
	// MPropertyStartGroup = "Firing"
	int32 m_nRecoilSeed;
	int32 m_nSpreadSeed;
	float32 m_flTimeToIdleAfterFire;
	float32 m_flIdleInterval;
	float32 m_flAttackMovespeedFactor;
	float32 m_flHeatPerShot;
	float32 m_flInaccuracyPitchShift;
	float32 m_flInaccuracyAltSoundThreshold;
	float32 m_flBotAudibleRange;
	CUtlString m_szUseRadioSubtitle;
	// MPropertyStartGroup = "Zooming"
	bool m_bUnzoomsAfterShot;
	bool m_bHideViewModelWhenZoomed;
	int32 m_nZoomLevels;
	int32 m_nZoomFOV1;
	int32 m_nZoomFOV2;
	float32 m_flZoomTime0;
	float32 m_flZoomTime1;
	float32 m_flZoomTime2;
	// MPropertyStartGroup = "Iron Sights"
	float32 m_flIronSightPullUpSpeed;
	float32 m_flIronSightPutDownSpeed;
	float32 m_flIronSightFOV;
	float32 m_flIronSightPivotForward;
	float32 m_flIronSightLooseness;
	QAngle m_angPivotAngle;
	Vector m_vecIronSightEyePos;
	// MPropertyStartGroup = "Damage"
	int32 m_nDamage;
	float32 m_flHeadshotMultiplier;
	float32 m_flArmorRatio;
	float32 m_flPenetration;
	float32 m_flRange;
	float32 m_flRangeModifier;
	float32 m_flFlinchVelocityModifierLarge;
	float32 m_flFlinchVelocityModifierSmall;
	// MPropertyStartGroup = "Recovery"
	float32 m_flRecoveryTimeCrouch;
	float32 m_flRecoveryTimeStand;
	float32 m_flRecoveryTimeCrouchFinal;
	float32 m_flRecoveryTimeStandFinal;
	int32 m_nRecoveryTransitionStartBullet;
	int32 m_nRecoveryTransitionEndBullet;
	// MPropertyStartGroup = "Grenade Data"
	float32 m_flThrowVelocity;
	Vector m_vSmokeColor;
	CGlobalSymbol m_szAnimClass;
};
