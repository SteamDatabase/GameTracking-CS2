class C_OP_ModelCull : public CParticleFunctionOperator
{
	int32 m_nControlPointNumber;
	bool m_bBoundBox;
	bool m_bCullOutside;
	bool m_bUseBones;
	char[128] m_HitboxSetName;
};
