class C_CSGO_PreviewPlayer_GraphController : public CAnimGraphControllerBase
{
	CAnimGraphParamOptionalRef< char* > m_pszCharacterMode;
	CAnimGraphParamOptionalRef< char* > m_pszTeamPreviewVariant;
	CAnimGraphParamOptionalRef< char* > m_pszTeamPreviewPosition;
	CAnimGraphParamOptionalRef< char* > m_pszEndOfMatchCelebration;
	CAnimGraphParamOptionalRef< int32 > m_nTeamPreviewRandom;
	CAnimGraphParamOptionalRef< char* > m_pszWeaponState;
	CAnimGraphParamOptionalRef< char* > m_pszWeaponType;
	CAnimGraphParamOptionalRef< bool > m_bCT;
};
