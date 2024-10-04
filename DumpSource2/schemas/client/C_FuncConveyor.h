class C_FuncConveyor : public C_BaseModelEntity
{
	Vector m_vecMoveDirEntitySpace;
	float32 m_flTargetSpeed;
	GameTick_t m_nTransitionStartTick;
	int32 m_nTransitionDurationTicks;
	float32 m_flTransitionStartSpeed;
	C_NetworkUtlVectorBase< CHandle< C_BaseEntity > > m_hConveyorModels;
	float32 m_flCurrentConveyorOffset;
	float32 m_flCurrentConveyorSpeed;
};
