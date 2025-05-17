// MNetworkIncludeByName = "m_fFlags"
// MNetworkOverride = "m_fFlags C_BaseEntity"
// MNetworkOverride = "m_vecX CNetworkOriginCellCoordQuantizedVector"
// MNetworkOverride = "m_vecY CNetworkOriginCellCoordQuantizedVector"
// MNetworkOverride = "m_vecZ CNetworkOriginCellCoordQuantizedVector"
// MNetworkOverride = "m_angRotation CGameSceneNode"
// MNetworkVarNames = "Vector m_vecMoveDirEntitySpace"
// MNetworkVarNames = "float32 m_flTargetSpeed"
// MNetworkVarNames = "GameTick_t m_nTransitionStartTick"
// MNetworkVarNames = "int m_nTransitionDurationTicks"
// MNetworkVarNames = "float32 m_flTransitionStartSpeed"
// MNetworkVarNames = "EHANDLE m_hConveyorModels"
class C_FuncConveyor : public C_BaseModelEntity
{
	// MNetworkEnable
	Vector m_vecMoveDirEntitySpace;
	// MNetworkEnable
	float32 m_flTargetSpeed;
	// MNetworkEnable
	GameTick_t m_nTransitionStartTick;
	// MNetworkEnable
	int32 m_nTransitionDurationTicks;
	// MNetworkEnable
	float32 m_flTransitionStartSpeed;
	// MNetworkEnable
	C_NetworkUtlVectorBase< CHandle< C_BaseEntity > > m_hConveyorModels;
	float32 m_flCurrentConveyorOffset;
	float32 m_flCurrentConveyorSpeed;
};
