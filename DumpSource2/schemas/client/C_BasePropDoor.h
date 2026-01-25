// MNetworkExcludeByName = "m_flexWeight"
// MNetworkExcludeByUserGroup = "m_flPoseParameter"
// MNetworkExcludeByName = "m_animationController.m_flPlaybackRate"
// MNetworkExcludeByUserGroup = "overlay_vars"
// MNetworkIncludeByName = "m_spawnflags"
// MNetworkVarNames = "DoorState_t m_eDoorState"
// MNetworkVarNames = "bool m_bLocked"
// MNetworkVarNames = "bool m_bNoNPCs"
// MNetworkVarNames = "Vector m_closedPosition"
// MNetworkVarNames = "QAngle m_closedAngles"
// MNetworkVarNames = "CHandle< C_BasePropDoor> m_hMaster"
class C_BasePropDoor : public C_DynamicProp
{
	// MNetworkEnable
	// MNotSaved
	DoorState_t m_eDoorState;
	// MNotSaved
	bool m_modelChanged;
	// MNetworkEnable
	// MNotSaved
	bool m_bLocked;
	// MNetworkEnable
	// MNotSaved
	bool m_bNoNPCs;
	// MNetworkEnable
	// MNotSaved
	Vector m_closedPosition;
	// MNetworkEnable
	// MNotSaved
	QAngle m_closedAngles;
	// MNetworkEnable
	// MNotSaved
	CHandle< C_BasePropDoor > m_hMaster;
	// MNotSaved
	Vector m_vWhereToSetLightingOrigin;
};
