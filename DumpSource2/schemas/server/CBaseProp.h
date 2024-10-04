class CBaseProp : public CBaseAnimGraph
{
	bool m_bModelOverrodeBlockLOS;
	int32 m_iShapeType;
	bool m_bConformToCollisionBounds;
	matrix3x4_t m_mPreferredCatchTransform;
}
