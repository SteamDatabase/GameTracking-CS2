class CCSPlayer_RadioServices : public CPlayerPawnComponent
{
	GameTime_t m_flGotHostageTalkTimer;
	GameTime_t m_flDefusingTalkTimer;
	GameTime_t m_flC4PlantTalkTimer;
	GameTime_t[3] m_flRadioTokenSlots;
	bool m_bIgnoreRadio;
}
