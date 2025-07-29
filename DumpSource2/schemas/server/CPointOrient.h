// MEntityAllowsPortraitWorldSpawn
class CPointOrient : public CBaseEntity
{
	CUtlSymbolLarge m_iszSpawnTargetName;
	CHandle< CBaseEntity > m_hTarget;
	bool m_bActive;
	PointOrientGoalDirectionType_t m_nGoalDirection;
	PointOrientConstraint_t m_nConstraint;
	float32 m_flMaxTurnRate;
	GameTime_t m_flLastGameTime;
};
