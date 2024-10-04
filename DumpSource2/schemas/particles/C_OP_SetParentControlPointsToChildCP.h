class C_OP_SetParentControlPointsToChildCP : public CParticleFunctionPreEmission
{
	int32 m_nChildGroupID;
	int32 m_nChildControlPoint;
	int32 m_nNumControlPoints;
	int32 m_nFirstSourcePoint;
	bool m_bSetOrientation;
};
