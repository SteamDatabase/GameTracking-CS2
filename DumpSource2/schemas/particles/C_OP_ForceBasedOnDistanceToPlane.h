class C_OP_ForceBasedOnDistanceToPlane : public CParticleFunctionForce
{
	float32 m_flMinDist;
	Vector m_vecForceAtMinDist;
	float32 m_flMaxDist;
	Vector m_vecForceAtMaxDist;
	Vector m_vecPlaneNormal;
	int32 m_nControlPointNumber;
	float32 m_flExponent;
};
