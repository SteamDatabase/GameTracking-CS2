// MNetworkExcludeByName = "m_flexWeight"
// MNetworkExcludeByName = "m_blinktoggle"
// MNetworkExcludeByUserGroup = "m_flPoseParameter"
// MNetworkExcludeByName = "m_animationController.m_flPlaybackRate"
// MNetworkExcludeByUserGroup = "overlay_vars"
// MNetworkIncludeByName = "m_spawnflags"
// MNetworkVarNames = "DoorState_t m_eDoorState"
// MNetworkVarNames = "bool m_bLocked"
// MNetworkVarNames = "bool m_bNoNPCs"
// MNetworkVarNames = "Vector m_closedPosition"
// MNetworkVarNames = "QAngle m_closedAngles"
// MNetworkVarNames = "CHandle< CBasePropDoor> m_hMaster"
class CBasePropDoor : public CDynamicProp
{
	float32 m_flAutoReturnDelay;
	CUtlVector< CHandle< CBasePropDoor > > m_hDoorList;
	int32 m_nHardwareType;
	bool m_bNeedsHardware;
	// MNetworkEnable
	DoorState_t m_eDoorState;
	// MNetworkEnable
	bool m_bLocked;
	// MNetworkEnable
	bool m_bNoNPCs;
	// MNetworkEnable
	Vector m_closedPosition;
	// MNetworkEnable
	QAngle m_closedAngles;
	CHandle< CBaseEntity > m_hBlocker;
	bool m_bFirstBlocked;
	locksound_t m_ls;
	bool m_bForceClosed;
	Vector m_vecLatchWorldPosition;
	CHandle< CBaseEntity > m_hActivator;
	CUtlSymbolLarge m_SoundMoving;
	CUtlSymbolLarge m_SoundOpen;
	CUtlSymbolLarge m_SoundClose;
	CUtlSymbolLarge m_SoundLock;
	CUtlSymbolLarge m_SoundUnlock;
	CUtlSymbolLarge m_SoundLatch;
	CUtlSymbolLarge m_SoundPound;
	CUtlSymbolLarge m_SoundJiggle;
	CUtlSymbolLarge m_SoundLockedAnim;
	int32 m_numCloseAttempts;
	CUtlStringToken m_nPhysicsMaterial;
	CUtlSymbolLarge m_SlaveName;
	// MNetworkEnable
	CHandle< CBasePropDoor > m_hMaster;
	CEntityIOOutput m_OnBlockedClosing;
	CEntityIOOutput m_OnBlockedOpening;
	CEntityIOOutput m_OnUnblockedClosing;
	CEntityIOOutput m_OnUnblockedOpening;
	CEntityIOOutput m_OnFullyClosed;
	CEntityIOOutput m_OnFullyOpen;
	CEntityIOOutput m_OnClose;
	CEntityIOOutput m_OnOpen;
	CEntityIOOutput m_OnLockedUse;
	CEntityIOOutput m_OnAjarOpen;
};
