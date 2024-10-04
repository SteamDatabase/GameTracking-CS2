class CPhysicsSpring : public CBaseEntity
{
	float32 m_flFrequency;
	float32 m_flDampingRatio;
	float32 m_flRestLength;
	CUtlSymbolLarge m_nameAttachStart;
	CUtlSymbolLarge m_nameAttachEnd;
	Vector m_start;
	Vector m_end;
	uint32 m_teleportTick;
}
