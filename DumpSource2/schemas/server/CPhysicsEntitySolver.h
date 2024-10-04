class CPhysicsEntitySolver : public CLogicalEntity
{
	CHandle< CBaseEntity > m_hMovingEntity;
	CHandle< CBaseEntity > m_hPhysicsBlocker;
	float32 m_separationDuration;
	GameTime_t m_cancelTime;
};
