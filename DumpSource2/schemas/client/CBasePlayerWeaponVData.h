// MGetKV3ClassDefaults = {
//	"_class": "CBasePlayerWeaponVData",
//	"m_szWorldModel": "",
//	"m_sToolsOnlyOwnerModelName": "",
//	"m_bBuiltRightHanded": true,
//	"m_bAllowFlipping": true,
//	"m_sMuzzleAttachment": "muzzle",
//	"m_szMuzzleFlashParticle": "",
//	"m_szMuzzleFlashParticleConfig": "",
//	"m_szBarrelSmokeParticle": "",
//	"m_nMuzzleSmokeShotThreshold": 4,
//	"m_flMuzzleSmokeTimeout": 0.250000,
//	"m_flMuzzleSmokeDecrementRate": 1.000000,
//	"m_bLinkedCooldowns": false,
//	"m_iFlags": "",
//	"m_nPrimaryAmmoType": "",
//	"m_nSecondaryAmmoType": "",
//	"m_iMaxClip1": 0,
//	"m_iMaxClip2": 0,
//	"m_iDefaultClip1": -1,
//	"m_iDefaultClip2": -1,
//	"m_bReserveAmmoAsClips": false,
//	"m_bTreatAsSingleClip": false,
//	"m_iWeight": 0,
//	"m_bAutoSwitchTo": true,
//	"m_bAutoSwitchFrom": true,
//	"m_iRumbleEffect": "RUMBLE_INVALID",
//	"m_flDropSpeed": 300.000000,
//	"m_iSlot": 0,
//	"m_iPosition": 0,
//	"m_aShootSounds":
//	{
//	}
//}
class CBasePlayerWeaponVData : public CEntitySubclassVDataBase
{
	// MPropertyStartGroup = "Visuals"
	// MPropertyDescription = "Model used on the ground or held by an entity"
	// MPropertyProvidesEditContextString = "ToolEditContext_ID_VMDL"
	CResourceNameTyped< CWeakHandle< InfoForResourceTypeCModel > > m_szWorldModel;
	// MPropertyDescription = "Model used by the tools only to populate comboboxes for things like animgraph parameter pickers"
	CResourceNameTyped< CWeakHandle< InfoForResourceTypeCModel > > m_sToolsOnlyOwnerModelName;
	// MPropertyDescription = "Was the weapon was built right-handed?"
	bool m_bBuiltRightHanded;
	// MPropertyDescription = "Allows flipping the model, regardless of whether it is built left or right handed"
	bool m_bAllowFlipping;
	// MPropertyDescription = "Attachment to fire bullets from"
	CAttachmentNameSymbolWithStorage m_sMuzzleAttachment;
	// MPropertyDescription = "Effect when firing this weapon"
	CResourceNameTyped< CWeakHandle< InfoForResourceTypeIParticleSystemDefinition > > m_szMuzzleFlashParticle;
	// MPropertyDescription = "Effect Config for Muzzle Flash - if set, will use this config specified in the particle effect, using whatever CP configuration is specified there, vdata muzzleflash attachment will be ignored"
	// MPropertyAttributeEditor = "ParticleConfigName()"
	// MPropertyEditContextOverrideKey (UNKNOWN FOR PARSER)
	CUtlString m_szMuzzleFlashParticleConfig;
	// MPropertyDescription = "Barrel smoke after firing this weapon"
	CResourceNameTyped< CWeakHandle< InfoForResourceTypeIParticleSystemDefinition > > m_szBarrelSmokeParticle;
	// MPropertyDescription = "Barrel smoke shot threshold to create smoke"
	uint8 m_nMuzzleSmokeShotThreshold;
	// MPropertyDescription = "Barrel smoke shot timeout"
	float32 m_flMuzzleSmokeTimeout;
	// MPropertyDescription = "Barrel smoke decrement rate when not firing"
	float32 m_flMuzzleSmokeDecrementRate;
	// MPropertyStartGroup = "Behavior"
	// MPropertyDescription = "Should both primary and secondary attacks be cooled down together (so cooling down primary attack would cooldown both primary + secondary attacks)?"
	bool m_bLinkedCooldowns;
	ItemFlagTypes_t m_iFlags;
	// MPropertyStartGroup = "Ammo"
	// MPropertyAttributeEditor = "VDataChoice( scripts/ammo.vdata )"
	// MPropertyCustomFGDType = "string"
	AmmoIndex_t m_nPrimaryAmmoType;
	// MPropertyAttributeEditor = "VDataChoice( scripts/ammo.vdata )"
	// MPropertyCustomFGDType = "string"
	AmmoIndex_t m_nSecondaryAmmoType;
	// MPropertyFriendlyName = "Primary Clip Size"
	// MPropertyDescription = "How many bullets this gun can fire before it reloads (0 if no clip)"
	// MPropertyAttributeRange = "0 255"
	int32 m_iMaxClip1;
	// MPropertyFriendlyName = "Secondary Clip Size"
	// MPropertyDescription = "How many secondary bullets this gun can fire before it reloads (0 if no clip)"
	// MPropertyAttributeRange = "0 255"
	int32 m_iMaxClip2;
	// MPropertyDescription = "Primary Initial Clip (-1 means use clip size)"
	// MPropertyAttributeRange = "-1 255"
	int32 m_iDefaultClip1;
	// MPropertyDescription = "Secondary Initial Clip (-1 means use clip size)"
	// MPropertyAttributeRange = "-1 255"
	int32 m_iDefaultClip2;
	// MPropertyDescription = "Indicates whether to treat reserve ammo as clips (reloads) instead of raw bullets"
	bool m_bReserveAmmoAsClips;
	// MPropertyDescription = "Regardless of ammo position, we'll always use clip1 as where our bullets come from"
	bool m_bTreatAsSingleClip;
	// MPropertyStartGroup = "UI"
	// MPropertyDescription = "This value used to determine this weapon's importance in autoselection"
	int32 m_iWeight;
	// MPropertyFriendlyName = "Safe To Auto-Switch To"
	// MPropertyDescription = "Whether this weapon is safe to automatically switch to (should be false for eg. explosives that can the player may accidentally hurt themselves with)"
	bool m_bAutoSwitchTo;
	// MPropertyFriendlyName = "Safe To Auto-Switch Away From"
	bool m_bAutoSwitchFrom;
	RumbleEffect_t m_iRumbleEffect;
	float32 m_flDropSpeed;
	// MPropertyFriendlyName = "HUD Bucket"
	// MPropertyDescription = "Which 'column' to display this weapon in the HUD"
	int32 m_iSlot;
	// MPropertyFriendlyName = "HUD Bucket Position"
	// MPropertyDescription = "Which 'row' to display this weapon in the HUD"
	int32 m_iPosition;
	// MPropertyStartGroup = "Sounds"
	CUtlOrderedMap< WeaponSound_t, CSoundEventName > m_aShootSounds;
};
