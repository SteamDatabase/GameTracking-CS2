class CPhysLength : public CPhysConstraint
{
	Vector[2] m_offset;
	Vector m_vecAttach;
	float32 m_addLength;
	float32 m_minLength;
	float32 m_totalLength;
	bool m_bEnableCollision;
}
