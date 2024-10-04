class CTriggerSndSosOpvar : public CBaseTrigger
{
	CUtlVector< CHandle< CBaseEntity > > m_hTouchingPlayers;
	Vector m_flPosition;
	float32 m_flCenterSize;
	float32 m_flMinVal;
	float32 m_flMaxVal;
	CUtlSymbolLarge m_opvarName;
	CUtlSymbolLarge m_stackName;
	CUtlSymbolLarge m_operatorName;
	bool m_bVolIs2D;
	char[256] m_opvarNameChar;
	char[256] m_stackNameChar;
	char[256] m_operatorNameChar;
	Vector m_VecNormPos;
	float32 m_flNormCenterSize;
}
