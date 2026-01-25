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
	// MNotSaved
	Vector m_pos;
	// MNotSaved
	Vector m_vel;
	// MNotSaved
	QAngle m_angles;
	// MNotSaved
	int32 m_localLifeState;
	// MNotSaved
	float32 m_deathDepth;
	// MNotSaved
	float32 m_deathAngle;
	// MNotSaved
	float32 m_buoyancy;
	// MNotSaved
	CountdownTimer m_wiggleTimer;
	// MNotSaved
	float32 m_wigglePhase;
	// MNotSaved
	float32 m_wiggleRate;
	// MNotSaved
	Vector m_actualPos;
	// MNotSaved
	QAngle m_actualAngles;
	// MNetworkEnable
	// MNetworkEncoder = "coord"
	// MNotSaved
	Vector m_poolOrigin;
	// MNetworkEnable
	// MNotSaved
	float32 m_waterLevel;
	// MNotSaved
	bool m_gotUpdate;
	// MNetworkEnable
	// MNetworkSerializer = "fish_pos_x"
	// MNetworkChangeCallback = "OnPosChanged"
	// MNotSaved
	float32 m_x;
	// MNetworkEnable
	// MNetworkSerializer = "fish_pos_y"
	// MNetworkChangeCallback = "OnPosChanged"
	// MNotSaved
	float32 m_y;
	// MNetworkEnable
	// MNetworkSerializer = "fish_pos_z"
	// MNetworkChangeCallback = "OnPosChanged"
	// MNotSaved
	float32 m_z;
	// MNetworkEnable
	// MNetworkSerializer = "angle_normalize_positive"
	// MNetworkBitCount = 7
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 360.000000
	// MNetworkEncodeFlags = 1
	// MNetworkChangeCallback = "OnAngChanged"
	// MNotSaved
	float32 m_angle;
	// MNotSaved
	float32[20] m_errorHistory;
	// MNotSaved
	int32 m_errorHistoryIndex;
	// MNotSaved
	int32 m_errorHistoryCount;
	// MNotSaved
	float32 m_averageError;
};
