class CTimerEntity : public CLogicalEntity
{
	CEntityIOOutput m_OnTimer;
	CEntityIOOutput m_OnTimerHigh;
	CEntityIOOutput m_OnTimerLow;
	int32 m_iDisabled;
	float32 m_flInitialDelay;
	float32 m_flRefireTime;
	bool m_bUpDownState;
	int32 m_iUseRandomTime;
	bool m_bPauseAfterFiring;
	float32 m_flLowerRandomBound;
	float32 m_flUpperRandomBound;
	float32 m_flRemainingTime;
	bool m_bPaused;
};
