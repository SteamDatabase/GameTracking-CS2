class C_OP_PlanarConstraint : public CParticleFunctionConstraint
{
	Vector m_PointOnPlane;
	Vector m_PlaneNormal;
	int32 m_nControlPointNumber;
	bool m_bGlobalOrigin;
	bool m_bGlobalNormal;
	CPerParticleFloatInput m_flRadiusScale;
	CParticleCollectionFloatInput m_flMaximumDistanceToCP;
	bool m_bUseOldCode;
};
