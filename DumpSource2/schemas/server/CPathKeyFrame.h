class CPathKeyFrame : public CLogicalEntity
{
	Vector m_Origin;
	QAngle m_Angles;
	Quaternion m_qAngle;
	CUtlSymbolLarge m_iNextKey;
	float32 m_flNextTime;
	CPathKeyFrame* m_pNextKey;
	CPathKeyFrame* m_pPrevKey;
	float32 m_flMoveSpeed;
};
