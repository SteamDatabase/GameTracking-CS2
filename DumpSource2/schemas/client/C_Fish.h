class C_Fish : public CBaseAnimGraph
{
	Vector m_pos;
	Vector m_vel;
	QAngle m_angles;
	int32 m_localLifeState;
	float32 m_deathDepth;
	float32 m_deathAngle;
	float32 m_buoyancy;
	CountdownTimer m_wiggleTimer;
	float32 m_wigglePhase;
	float32 m_wiggleRate;
	Vector m_actualPos;
	QAngle m_actualAngles;
	Vector m_poolOrigin;
	float32 m_waterLevel;
	bool m_gotUpdate;
	float32 m_x;
	float32 m_y;
	float32 m_z;
	float32 m_angle;
	float32[20] m_errorHistory;
	int32 m_errorHistoryIndex;
	int32 m_errorHistoryCount;
	float32 m_averageError;
};
