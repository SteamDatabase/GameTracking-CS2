class CCSPlayer_WaterServices : public CPlayer_WaterServices
{
	GameTime_t m_NextDrownDamageTime;
	int32 m_nDrownDmgRate;
	GameTime_t m_AirFinishedTime;
	float32 m_flWaterJumpTime;
	Vector m_vecWaterJumpVel;
	float32 m_flSwimSoundTime;
};
