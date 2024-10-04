class C_OP_ConstrainDistanceToUserSpecifiedPath : public CParticleFunctionConstraint
{
	float32 m_fMinDistance;
	float32 m_flMaxDistance;
	float32 m_flTimeScale;
	bool m_bLoopedPath;
	CUtlVector< PointDefinitionWithTimeValues_t > m_pointList;
};
