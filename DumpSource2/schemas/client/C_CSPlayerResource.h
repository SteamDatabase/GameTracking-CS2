class C_CSPlayerResource : public C_BaseEntity
{
	bool[12] m_bHostageAlive;
	bool[12] m_isHostageFollowingSomeone;
	CEntityIndex[12] m_iHostageEntityIDs;
	Vector m_bombsiteCenterA;
	Vector m_bombsiteCenterB;
	int32[4] m_hostageRescueX;
	int32[4] m_hostageRescueY;
	int32[4] m_hostageRescueZ;
	bool m_bEndMatchNextMapAllVoted;
	bool m_foundGoalPositions;
}
