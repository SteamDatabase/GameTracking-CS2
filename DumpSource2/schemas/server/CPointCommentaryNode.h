class CPointCommentaryNode : public CBaseAnimGraph
{
	CUtlSymbolLarge m_iszPreCommands;
	CUtlSymbolLarge m_iszPostCommands;
	CUtlSymbolLarge m_iszCommentaryFile;
	CUtlSymbolLarge m_iszViewTarget;
	CHandle< CBaseEntity > m_hViewTarget;
	CHandle< CBaseEntity > m_hViewTargetAngles;
	CUtlSymbolLarge m_iszViewPosition;
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
	Vector m_vecTeleportOrigin;
	GameTime_t m_flAbortedPlaybackAt;
	CEntityIOOutput m_pOnCommentaryStarted;
	CEntityIOOutput m_pOnCommentaryStopped;
	bool m_bActive;
	GameTime_t m_flStartTime;
	float32 m_flStartTimeInCommentary;
	CUtlSymbolLarge m_iszTitle;
	CUtlSymbolLarge m_iszSpeakers;
	int32 m_iNodeNumber;
	int32 m_iNodeNumberMax;
	bool m_bListenedTo;
}
