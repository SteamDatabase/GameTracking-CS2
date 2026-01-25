// MNetworkIncludeByName = "m_nModelIndex"
// MNetworkIncludeByName = "m_lifeState"
// MNetworkVarNames = "float32 m_x"
// MNetworkVarNames = "float32 m_y"
// MNetworkVarNames = "float32 m_z"
// MNetworkVarNames = "float32 m_angle"
// MNetworkVarNames = "Vector m_poolOrigin"
// MNetworkVarNames = "float32 m_waterLevel"
class CFish : public CBaseAnimGraph
{
	CHandle< CFishPool > m_pool;
	uint32 m_id;
	// MNetworkEnable
	// MNetworkSerializer = "fish_pos_x"
	// MNotSaved
	float32 m_x;
	// MNetworkEnable
	// MNetworkSerializer = "fish_pos_y"
	// MNotSaved
	float32 m_y;
	// MNetworkEnable
	// MNetworkSerializer = "fish_pos_z"
	// MNotSaved
	float32 m_z;
	// MNetworkEnable
	// MNetworkSerializer = "angle_normalize_positive"
	// MNetworkBitCount = 7
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 360.000000
	// MNetworkEncodeFlags = 1
	float32 m_angle;
	float32 m_angleChange;
	Vector m_forward;
	Vector m_perp;
	// MNetworkEnable
	// MNetworkEncoder = "coord"
	Vector m_poolOrigin;
	// MNetworkEnable
	float32 m_waterLevel;
	float32 m_speed;
	float32 m_desiredSpeed;
	float32 m_calmSpeed;
	float32 m_panicSpeed;
	float32 m_avoidRange;
	// MNotSaved
	CountdownTimer m_turnTimer;
	bool m_turnClockwise;
	// MNotSaved
	CountdownTimer m_goTimer;
	// MNotSaved
	CountdownTimer m_moveTimer;
	// MNotSaved
	CountdownTimer m_panicTimer;
	// MNotSaved
	CountdownTimer m_disperseTimer;
	// MNotSaved
	CountdownTimer m_proximityTimer;
	// MNotSaved
	CUtlVector< CFish* > m_visible;
};
