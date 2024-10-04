class C_OP_LockToPointList : public CParticleFunctionOperator
{
	ParticleAttributeIndex_t m_nFieldOutput;
	CUtlVector< PointDefinition_t > m_pointList;
	bool m_bPlaceAlongPath;
	bool m_bClosedLoop;
	int32 m_nNumPointsAlongPath;
};
