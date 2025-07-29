// MNetworkExcludeByName = "m_flAnimTime"
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
// MNetworkVarNames = "CHandle< C_BasePropDoor> m_hMaster"
class C_BasePropDoor : public C_DynamicProp
{
	// MNetworkEnable
	DoorState_t m_eDoorState;
	bool m_modelChanged;
	// MNetworkEnable
	bool m_bLocked;
	// MNetworkEnable
	bool m_bNoNPCs;
	// MNetworkEnable
	Vector m_closedPosition;
	// MNetworkEnable
	QAngle m_closedAngles;
	// MNetworkEnable
	CHandle< C_BasePropDoor > m_hMaster;
	Vector m_vWhereToSetLightingOrigin;
};
