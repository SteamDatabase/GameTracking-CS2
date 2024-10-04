class CChicken : public CDynamicProp
{
	CAttributeContainer m_AttributeManager;
	CountdownTimer m_updateTimer;
	Vector m_stuckAnchor;
	CountdownTimer m_stuckTimer;
	CountdownTimer m_collisionStuckTimer;
	bool m_isOnGround;
	Vector m_vFallVelocity;
	ChickenActivity m_desiredActivity;
	ChickenActivity m_currentActivity;
	CountdownTimer m_activityTimer;
	float32 m_turnRate;
	CHandle< CBaseEntity > m_fleeFrom;
	CountdownTimer m_moveRateThrottleTimer;
	CountdownTimer m_startleTimer;
	CountdownTimer m_vocalizeTimer;
	GameTime_t m_flWhenZombified;
	bool m_jumpedThisFrame;
	CHandle< CCSPlayerPawn > m_leader;
	CountdownTimer m_reuseTimer;
	bool m_hasBeenUsed;
	CountdownTimer m_jumpTimer;
	float32 m_flLastJumpTime;
	bool m_bInJump;
	CountdownTimer m_repathTimer;
	Vector m_vecPathGoal;
	GameTime_t m_flActiveFollowStartTime;
	CountdownTimer m_followMinuteTimer;
	CountdownTimer m_BlockDirectionTimer;
}
