class C_BulletHitModel : public CBaseAnimGraph
{
	matrix3x4_t m_matLocal;
	int32 m_iBoneIndex;
	CHandle< C_BaseEntity > m_hPlayerParent;
	bool m_bIsHit;
	float32 m_flTimeCreated;
	Vector m_vecStartPos;
}
