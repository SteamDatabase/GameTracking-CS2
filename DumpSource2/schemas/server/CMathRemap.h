class CMathRemap : public CLogicalEntity
{
	float32 m_flInMin;
	float32 m_flInMax;
	float32 m_flOut1;
	float32 m_flOut2;
	float32 m_flOldInValue;
	bool m_bEnabled;
	CEntityOutputTemplate< float32 > m_OutValue;
	CEntityIOOutput m_OnRoseAboveMin;
	CEntityIOOutput m_OnRoseAboveMax;
	CEntityIOOutput m_OnFellBelowMin;
	CEntityIOOutput m_OnFellBelowMax;
};
