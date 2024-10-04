class C_ColorCorrection : public C_BaseEntity
{
	Vector m_vecOrigin;
	float32 m_MinFalloff;
	float32 m_MaxFalloff;
	float32 m_flFadeInDuration;
	float32 m_flFadeOutDuration;
	float32 m_flMaxWeight;
	float32 m_flCurWeight;
	char[512] m_netlookupFilename;
	bool m_bEnabled;
	bool m_bMaster;
	bool m_bClientSide;
	bool m_bExclusive;
	bool[1] m_bEnabledOnClient;
	float32[1] m_flCurWeightOnClient;
	bool[1] m_bFadingIn;
	float32[1] m_flFadeStartWeight;
	float32[1] m_flFadeStartTime;
	float32[1] m_flFadeDuration;
}
