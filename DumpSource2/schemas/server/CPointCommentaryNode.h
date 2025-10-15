// MNetworkVarNames = "string_t m_iszCommentaryFile"
// MNetworkVarNames = "CHandle< CBaseEntity> m_hViewPosition"
// MNetworkVarNames = "bool m_bActive"
// MNetworkVarNames = "GameTime_t m_flStartTime"
// MNetworkVarNames = "float32 m_flStartTimeInCommentary"
// MNetworkVarNames = "string_t m_iszTitle"
// MNetworkVarNames = "string_t m_iszSpeakers"
// MNetworkVarNames = "int m_iNodeNumber"
// MNetworkVarNames = "int m_iNodeNumberMax"
// MNetworkVarNames = "bool m_bListenedTo"
class CPointCommentaryNode : public CBaseAnimGraph
{
	CUtlSymbolLarge m_iszPreCommands;
	CUtlSymbolLarge m_iszPostCommands;
	// MNetworkEnable
	CUtlSymbolLarge m_iszCommentaryFile;
	CUtlSymbolLarge m_iszViewTarget;
	CHandle< CBaseEntity > m_hViewTarget;
	CHandle< CBaseEntity > m_hViewTargetAngles;
	CUtlSymbolLarge m_iszViewPosition;
	// MNetworkEnable
	CHandle< CBaseEntity > m_hViewPosition;
	CHandle< CBaseEntity > m_hViewPositionMover;
	bool m_bPreventMovement;
	bool m_bUnderCrosshair;
	bool m_bUnstoppable;
	GameTime_t m_flFinishedTime;
	Vector m_vecFinishOrigin;
	QAngle m_vecOriginalAngles;
	QAngle m_vecFinishAngles;
	bool m_bPreventChangesWhileMoving;
	bool m_bDisabled;
	VectorWS m_vecTeleportOrigin;
	GameTime_t m_flAbortedPlaybackAt;
	CEntityIOOutput m_pOnCommentaryStarted;
	CEntityIOOutput m_pOnCommentaryStopped;
	// MNetworkEnable
	bool m_bActive;
	// MNetworkEnable
	GameTime_t m_flStartTime;
	// MNetworkEnable
	float32 m_flStartTimeInCommentary;
	// MNetworkEnable
	CUtlSymbolLarge m_iszTitle;
	// MNetworkEnable
	CUtlSymbolLarge m_iszSpeakers;
	// MNetworkEnable
	int32 m_iNodeNumber;
	// MNetworkEnable
	int32 m_iNodeNumberMax;
	// MNetworkEnable
	bool m_bListenedTo;
};
