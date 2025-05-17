// MNetworkIncludeByName = "m_fFlags"
// MNetworkOverride = "m_fFlags CBaseEntity"
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
class CFuncConveyor : public CBaseModelEntity
{
	CUtlSymbolLarge m_szConveyorModels;
	float32 m_flTransitionDurationSeconds;
	QAngle m_angMoveEntitySpace;
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
	CNetworkUtlVectorBase< CHandle< CBaseEntity > > m_hConveyorModels;
};
