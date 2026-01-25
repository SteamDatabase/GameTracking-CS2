class CTriggerSndSosOpvar : public CBaseTrigger
{
	// MNotSaved
	CUtlVector< CHandle< CBaseEntity > > m_hTouchingPlayers;
	// MNotSaved
	Vector m_flPosition;
	float32 m_flCenterSize;
	float32 m_flMinVal;
	float32 m_flMaxVal;
	CUtlSymbolLarge m_opvarName;
	CUtlSymbolLarge m_stackName;
	CUtlSymbolLarge m_operatorName;
	bool m_bVolIs2D;
	// MNotSaved
	char[256] m_opvarNameChar;
	// MNotSaved
	char[256] m_stackNameChar;
	// MNotSaved
	char[256] m_operatorNameChar;
	// MNotSaved
	Vector m_VecNormPos;
	// MNotSaved
	float32 m_flNormCenterSize;
};
