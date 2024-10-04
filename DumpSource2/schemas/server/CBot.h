class CBot
{
	CCSPlayerController* m_pController;
	CCSPlayerPawn* m_pPlayer;
	bool m_bHasSpawned;
	uint32 m_id;
	bool m_isRunning;
	bool m_isCrouching;
	float32 m_forwardSpeed;
	float32 m_leftSpeed;
	float32 m_verticalSpeed;
	uint64 m_buttonFlags;
	float32 m_jumpTimestamp;
	Vector m_viewForward;
	int32 m_postureStackIndex;
}
