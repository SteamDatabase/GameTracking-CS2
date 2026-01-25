class CLogicDistanceAutosave : public CLogicalEntity
{
	CUtlSymbolLarge m_iszTargetEntity;
	float32 m_flDistanceToPlayer;
	bool m_bForceNewLevelUnit;
	bool m_bCheckCough;
	// MNotSaved
	bool m_bThinkDangerous;
	// MNotSaved
	float32 m_flDangerousTime;
};
