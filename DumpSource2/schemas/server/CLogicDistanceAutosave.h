class CLogicDistanceAutosave : public CLogicalEntity
{
	CUtlSymbolLarge m_iszTargetEntity;
	float32 m_flDistanceToPlayer;
	bool m_bForceNewLevelUnit;
	bool m_bCheckCough;
	bool m_bThinkDangerous;
	float32 m_flDangerousTime;
};
