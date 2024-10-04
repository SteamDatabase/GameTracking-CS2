class CBtActionAim : public CBtNode
{
	CUtlString m_szSensorInputKey;
	CUtlString m_szAimReadyKey;
	float32 m_flZoomCooldownTimestamp;
	bool m_bDoneAiming;
	float32 m_flLerpStartTime;
	float32 m_flNextLookTargetLerpTime;
	float32 m_flPenaltyReductionRatio;
	QAngle m_NextLookTarget;
	CountdownTimer m_AimTimer;
	CountdownTimer m_SniperHoldTimer;
	CountdownTimer m_FocusIntervalTimer;
	bool m_bAcquired;
};
