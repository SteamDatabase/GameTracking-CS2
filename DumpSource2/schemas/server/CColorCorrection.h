class CColorCorrection : public CBaseEntity
{
	float32 m_flFadeInDuration;
	float32 m_flFadeOutDuration;
	float32 m_flStartFadeInWeight;
	float32 m_flStartFadeOutWeight;
	GameTime_t m_flTimeStartFadeIn;
	GameTime_t m_flTimeStartFadeOut;
	float32 m_flMaxWeight;
	bool m_bStartDisabled;
	bool m_bEnabled;
	bool m_bMaster;
	bool m_bClientSide;
	bool m_bExclusive;
	float32 m_MinFalloff;
	float32 m_MaxFalloff;
	float32 m_flCurWeight;
	char[512] m_netlookupFilename;
	CUtlSymbolLarge m_lookupFilename;
}
