class CBasePlayerWeaponVData : public CEntitySubclassVDataBase
{
	CResourceNameTyped< CWeakHandle< InfoForResourceTypeCModel > > m_szWorldModel;
	CResourceNameTyped< CWeakHandle< InfoForResourceTypeCModel > > m_sToolsOnlyOwnerModelName;
	bool m_bBuiltRightHanded;
	bool m_bAllowFlipping;
	CAttachmentNameSymbolWithStorage m_sMuzzleAttachment;
	CResourceNameTyped< CWeakHandle< InfoForResourceTypeIParticleSystemDefinition > > m_szMuzzleFlashParticle;
	bool m_bLinkedCooldowns;
	ItemFlagTypes_t m_iFlags;
	AmmoIndex_t m_nPrimaryAmmoType;
	AmmoIndex_t m_nSecondaryAmmoType;
	int32 m_iMaxClip1;
	int32 m_iMaxClip2;
	int32 m_iDefaultClip1;
	int32 m_iDefaultClip2;
	bool m_bReserveAmmoAsClips;
	int32 m_iWeight;
	bool m_bAutoSwitchTo;
	bool m_bAutoSwitchFrom;
	RumbleEffect_t m_iRumbleEffect;
	int32 m_iSlot;
	int32 m_iPosition;
	CUtlOrderedMap< WeaponSound_t, CSoundEventName > m_aShootSounds;
};
