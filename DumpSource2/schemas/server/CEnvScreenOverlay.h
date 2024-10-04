class CEnvScreenOverlay : public CPointEntity
{
	CUtlSymbolLarge[10] m_iszOverlayNames;
	float32[10] m_flOverlayTimes;
	GameTime_t m_flStartTime;
	int32 m_iDesiredOverlay;
	bool m_bIsActive;
};
