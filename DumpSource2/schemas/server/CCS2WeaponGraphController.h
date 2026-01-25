// MGetKV3ClassDefaults = {
//	"_class": "CCS2WeaponGraphController",
//	"m_hExternalGraph": 4294967295,
//	"m_action": null,
//	"m_bActionReset": null,
//	"m_flWeaponActionSpeedScale": null,
//	"m_weaponCategory": null,
//	"m_weaponType": null,
//	"m_weaponExtraInfo": null,
//	"m_flWeaponAmmo": null,
//	"m_flWeaponAmmoMax": null,
//	"m_flWeaponAmmoReserve": null,
//	"m_bWeaponIsSilenced": null,
//	"m_flWeaponIronsightAmount": null,
//	"m_bIsUsingLegacyModel": null,
//	"m_idleVariation": null,
//	"m_deployVariation": null,
//	"m_attackType": null,
//	"m_attackThrowStrength": null,
//	"m_flAttackVariation": null,
//	"m_inspectVariation": null,
//	"m_inspectExtraInfo": null,
//	"m_reloadStage": null
//}
class CCS2WeaponGraphController : public CAnimGraphControllerBase
{
	CAnimGraph2ParamOptionalRef< CGlobalSymbol > m_action;
	CAnimGraph2ParamOptionalRef< bool > m_bActionReset;
	CAnimGraph2ParamOptionalRef< float32 > m_flWeaponActionSpeedScale;
	CAnimGraph2ParamOptionalRef< CGlobalSymbol > m_weaponCategory;
	CAnimGraph2ParamOptionalRef< CGlobalSymbol > m_weaponType;
	CAnimGraph2ParamOptionalRef< CGlobalSymbol > m_weaponExtraInfo;
	CAnimGraph2ParamOptionalRef< float32 > m_flWeaponAmmo;
	CAnimGraph2ParamOptionalRef< float32 > m_flWeaponAmmoMax;
	CAnimGraph2ParamOptionalRef< float32 > m_flWeaponAmmoReserve;
	CAnimGraph2ParamOptionalRef< bool > m_bWeaponIsSilenced;
	CAnimGraph2ParamOptionalRef< float32 > m_flWeaponIronsightAmount;
	CAnimGraph2ParamOptionalRef< bool > m_bIsUsingLegacyModel;
	CAnimGraph2ParamOptionalRef< float32 > m_idleVariation;
	CAnimGraph2ParamOptionalRef< float32 > m_deployVariation;
	CAnimGraph2ParamOptionalRef< CGlobalSymbol > m_attackType;
	CAnimGraph2ParamOptionalRef< float32 > m_attackThrowStrength;
	CAnimGraph2ParamOptionalRef< float32 > m_flAttackVariation;
	CAnimGraph2ParamOptionalRef< float32 > m_inspectVariation;
	CAnimGraph2ParamOptionalRef< CGlobalSymbol > m_inspectExtraInfo;
	CAnimGraph2ParamOptionalRef< CGlobalSymbol > m_reloadStage;
};
