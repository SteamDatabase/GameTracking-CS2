class CLogicCompare : public CLogicalEntity
{
	float32 m_flInValue;
	float32 m_flCompareValue;
	CEntityOutputTemplate< float32 > m_OnLessThan;
	CEntityOutputTemplate< float32 > m_OnEqualTo;
	CEntityOutputTemplate< float32 > m_OnNotEqualTo;
	CEntityOutputTemplate< float32 > m_OnGreaterThan;
}
