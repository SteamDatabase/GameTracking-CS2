class CMomentaryRotButton : public CRotButton
{
	CEntityOutputTemplate< float32 > m_Position;
	CEntityIOOutput m_OnUnpressed;
	CEntityIOOutput m_OnFullyOpen;
	CEntityIOOutput m_OnFullyClosed;
	CEntityIOOutput m_OnReachedPosition;
	int32 m_lastUsed;
	QAngle m_start;
	QAngle m_end;
	float32 m_IdealYaw;
	CUtlSymbolLarge m_sNoise;
	bool m_bUpdateTarget;
	int32 m_direction;
	float32 m_returnSpeed;
	float32 m_flStartPosition;
}
