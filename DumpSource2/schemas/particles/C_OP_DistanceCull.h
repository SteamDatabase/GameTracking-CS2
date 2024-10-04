class C_OP_DistanceCull : public CParticleFunctionOperator
{
	int32 m_nControlPoint;
	Vector m_vecPointOffset;
	float32 m_flDistance;
	bool m_bCullInside;
};
