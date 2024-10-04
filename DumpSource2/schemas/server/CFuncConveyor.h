class CFuncConveyor : public CBaseModelEntity
{
	CUtlSymbolLarge m_szConveyorModels;
	float32 m_flTransitionDurationSeconds;
	QAngle m_angMoveEntitySpace;
	Vector m_vecMoveDirEntitySpace;
	float32 m_flTargetSpeed;
	GameTick_t m_nTransitionStartTick;
	int32 m_nTransitionDurationTicks;
	float32 m_flTransitionStartSpeed;
	CNetworkUtlVectorBase< CHandle< CBaseEntity > > m_hConveyorModels;
};
