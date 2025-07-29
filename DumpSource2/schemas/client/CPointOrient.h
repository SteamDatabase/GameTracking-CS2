// MEntityAllowsPortraitWorldSpawn
class CPointOrient : public C_BaseEntity
{
	CUtlSymbolLarge m_iszSpawnTargetName;
	CHandle< C_BaseEntity > m_hTarget;
	bool m_bActive;
	PointOrientGoalDirectionType_t m_nGoalDirection;
	PointOrientConstraint_t m_nConstraint;
	float32 m_flMaxTurnRate;
	GameTime_t m_flLastGameTime;
};
