// MNetworkVarNames = "bool m_bHostageAlive"
// MNetworkVarNames = "bool m_isHostageFollowingSomeone"
// MNetworkVarNames = "CEntityIndex m_iHostageEntityIDs"
// MNetworkVarNames = "Vector m_bombsiteCenterA"
// MNetworkVarNames = "Vector m_bombsiteCenterB"
// MNetworkVarNames = "int m_hostageRescueX"
// MNetworkVarNames = "int m_hostageRescueY"
// MNetworkVarNames = "int m_hostageRescueZ"
// MNetworkVarNames = "bool m_bEndMatchNextMapAllVoted"
class CCSPlayerResource : public CBaseEntity
{
	// MNetworkEnable
	bool[12] m_bHostageAlive;
	// MNetworkEnable
	bool[12] m_isHostageFollowingSomeone;
	// MNetworkEnable
	CEntityIndex[12] m_iHostageEntityIDs;
	// MNetworkEnable
	Vector m_bombsiteCenterA;
	// MNetworkEnable
	Vector m_bombsiteCenterB;
	// MNetworkEnable
	int32[4] m_hostageRescueX;
	// MNetworkEnable
	int32[4] m_hostageRescueY;
	// MNetworkEnable
	int32[4] m_hostageRescueZ;
	// MNetworkEnable
	bool m_bEndMatchNextMapAllVoted;
	bool m_foundGoalPositions;
};
