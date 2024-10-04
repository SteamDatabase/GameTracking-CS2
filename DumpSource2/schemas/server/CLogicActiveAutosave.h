class CLogicActiveAutosave : public CLogicAutosave
{
	int32 m_TriggerHitPoints;
	float32 m_flTimeToTrigger;
	GameTime_t m_flStartTime;
	float32 m_flDangerousTime;
};
