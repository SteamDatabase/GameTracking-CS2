class CPhysConstraint : public CLogicalEntity
{
	CUtlSymbolLarge m_nameAttach1;
	CUtlSymbolLarge m_nameAttach2;
	CHandle< CBaseEntity > m_hAttach1;
	CHandle< CBaseEntity > m_hAttach2;
	CUtlSymbolLarge m_nameAttachment1;
	CUtlSymbolLarge m_nameAttachment2;
	CUtlSymbolLarge m_breakSound;
	float32 m_forceLimit;
	float32 m_torqueLimit;
	uint32 m_teleportTick;
	float32 m_minTeleportDistance;
	bool m_bSnapObjectPositions;
	CEntityIOOutput m_OnBreak;
};
