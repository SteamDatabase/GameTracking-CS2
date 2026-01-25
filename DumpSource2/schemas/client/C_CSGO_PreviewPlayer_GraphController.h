// MGetKV3ClassDefaults = {
//	"_class": "C_CSGO_PreviewPlayer_GraphController",
//	"m_hExternalGraph": 4294967295,
//	"m_pszCharacterMode": null,
//	"m_pszTeamPreviewVariant": null,
//	"m_pszTeamPreviewPosition": null,
//	"m_pszEndOfMatchCelebration": null,
//	"m_nTeamPreviewRandom": null,
//	"m_pszWeaponState": null,
//	"m_pszWeaponType": null,
//	"m_bCT": null
//}
class C_CSGO_PreviewPlayer_GraphController : public CAnimGraphControllerBase
{
	CAnimGraphParamRef< char* > m_pszCharacterMode;
	CAnimGraphParamRef< char* > m_pszTeamPreviewVariant;
	CAnimGraphParamRef< char* > m_pszTeamPreviewPosition;
	CAnimGraphParamRef< char* > m_pszEndOfMatchCelebration;
	CAnimGraphParamRef< int32 > m_nTeamPreviewRandom;
	CAnimGraphParamRef< char* > m_pszWeaponState;
	CAnimGraphParamRef< char* > m_pszWeaponType;
	CAnimGraphParamRef< bool > m_bCT;
};
