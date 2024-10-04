class CFish : public CBaseAnimGraph
{
	CHandle< CFishPool > m_pool;
	uint32 m_id;
	float32 m_x;
	float32 m_y;
	float32 m_z;
	float32 m_angle;
	float32 m_angleChange;
	Vector m_forward;
	Vector m_perp;
	Vector m_poolOrigin;
	float32 m_waterLevel;
	float32 m_speed;
	float32 m_desiredSpeed;
	float32 m_calmSpeed;
	float32 m_panicSpeed;
	float32 m_avoidRange;
	CountdownTimer m_turnTimer;
	bool m_turnClockwise;
	CountdownTimer m_goTimer;
	CountdownTimer m_moveTimer;
	CountdownTimer m_panicTimer;
	CountdownTimer m_disperseTimer;
	CountdownTimer m_proximityTimer;
	CUtlVector< CFish* > m_visible;
};
