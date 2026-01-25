class CMathColorBlend : public CLogicalEntity
{
	float32 m_flInMin;
	float32 m_flInMax;
	Color m_OutColor1;
	Color m_OutColor2;
	CEntityOutputTemplate< Color, Color > m_OutValue;
};
