class C_OP_PlaneCull : public CParticleFunctionOperator
{
	int32 m_nPlaneControlPoint;
	Vector m_vecPlaneDirection;
	bool m_bLocalSpace;
	float32 m_flPlaneOffset;
};
