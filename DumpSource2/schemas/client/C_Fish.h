// MNetworkIncludeByName = "m_nModelIndex"
// MNetworkIncludeByName = "m_lifeState"
// MNetworkVarNames = "Vector m_poolOrigin"
// MNetworkVarNames = "float32 m_waterLevel"
// MNetworkVarNames = "float32 m_x"
// MNetworkVarNames = "float32 m_y"
// MNetworkVarNames = "float32 m_z"
// MNetworkVarNames = "float32 m_angle"
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
	// MNetworkEnable
	// MNetworkEncoder = "coord"
	Vector m_poolOrigin;
	// MNetworkEnable
	float32 m_waterLevel;
	bool m_gotUpdate;
	// MNetworkEnable
	// MNetworkSerializer = "fish_pos_x"
	// MNetworkChangeCallback = "OnPosChanged"
	float32 m_x;
	// MNetworkEnable
	// MNetworkSerializer = "fish_pos_y"
	// MNetworkChangeCallback = "OnPosChanged"
	float32 m_y;
	// MNetworkEnable
	// MNetworkSerializer = "fish_pos_z"
	// MNetworkChangeCallback = "OnPosChanged"
	float32 m_z;
	// MNetworkEnable
	// MNetworkSerializer = "angle_normalize_positive"
	// MNetworkBitCount = 7
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 360.000000
	// MNetworkEncodeFlags = 1
	// MNetworkChangeCallback = "OnAngChanged"
	float32 m_angle;
	float32[20] m_errorHistory;
	int32 m_errorHistoryIndex;
	int32 m_errorHistoryCount;
	float32 m_averageError;
};
