class C_EnvScreenOverlay : public C_PointEntity
{
	CUtlSymbolLarge[10] m_iszOverlayNames;
	float32[10] m_flOverlayTimes;
	GameTime_t m_flStartTime;
	int32 m_iDesiredOverlay;
	bool m_bIsActive;
	bool m_bWasActive;
	int32 m_iCachedDesiredOverlay;
	int32 m_iCurrentOverlay;
	GameTime_t m_flCurrentOverlayTime;
};
