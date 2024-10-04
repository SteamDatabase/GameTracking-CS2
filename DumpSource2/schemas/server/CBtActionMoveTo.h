class CBtActionMoveTo : public CBtNode
{
	CUtlString m_szDestinationInputKey;
	CUtlString m_szHidingSpotInputKey;
	CUtlString m_szThreatInputKey;
	Vector m_vecDestination;
	bool m_bAutoLookAdjust;
	bool m_bComputePath;
	float32 m_flDamagingAreasPenaltyCost;
	CountdownTimer m_CheckApproximateCornersTimer;
	CountdownTimer m_CheckHighPriorityItem;
	CountdownTimer m_RepathTimer;
	float32 m_flArrivalEpsilon;
	float32 m_flAdditionalArrivalEpsilon2D;
	float32 m_flHidingSpotCheckDistanceThreshold;
	float32 m_flNearestAreaDistanceThreshold;
};
