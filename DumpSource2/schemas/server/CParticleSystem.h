class CParticleSystem : public CBaseModelEntity
{
	char[512] m_szSnapshotFileName;
	bool m_bActive;
	bool m_bFrozen;
	float32 m_flFreezeTransitionDuration;
	int32 m_nStopType;
	bool m_bAnimateDuringGameplayPause;
	CStrongHandle< InfoForResourceTypeIParticleSystemDefinition > m_iEffectIndex;
	GameTime_t m_flStartTime;
	float32 m_flPreSimTime;
	Vector[4] m_vServerControlPoints;
	uint8[4] m_iServerControlPointAssignments;
	CHandle< CBaseEntity >[64] m_hControlPointEnts;
	bool m_bNoSave;
	bool m_bNoFreeze;
	bool m_bNoRamp;
	bool m_bStartActive;
	CUtlSymbolLarge m_iszEffectName;
	CUtlSymbolLarge[64] m_iszControlPointNames;
	int32 m_nDataCP;
	Vector m_vecDataCPValue;
	int32 m_nTintCP;
	Color m_clrTint;
};
