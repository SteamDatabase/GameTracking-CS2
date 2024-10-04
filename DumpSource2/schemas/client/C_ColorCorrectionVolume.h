class C_ColorCorrectionVolume : public C_BaseTrigger
{
	float32 m_LastEnterWeight;
	float32 m_LastEnterTime;
	float32 m_LastExitWeight;
	float32 m_LastExitTime;
	bool m_bEnabled;
	float32 m_MaxWeight;
	float32 m_FadeDuration;
	float32 m_Weight;
	char[512] m_lookupFilename;
}
