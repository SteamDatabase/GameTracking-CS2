// MNetworkVarNames = "bool m_bBombPlantedHere"
class CBombTarget : public CBaseTrigger
{
	CEntityIOOutput m_OnBombExplode;
	CEntityIOOutput m_OnBombPlanted;
	CEntityIOOutput m_OnBombDefused;
	bool m_bIsBombSiteB;
	bool m_bIsHeistBombTarget;
	// MNetworkEnable
	bool m_bBombPlantedHere;
	CUtlSymbolLarge m_szMountTarget;
	CHandle< CBaseEntity > m_hInstructorHint;
	int32 m_nBombSiteDesignation;
};
