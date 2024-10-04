class C_OP_ModelDampenMovement : public CParticleFunctionOperator
{
	int32 m_nControlPointNumber;
	bool m_bBoundBox;
	bool m_bOutside;
	bool m_bUseBones;
	char[128] m_HitboxSetName;
	CPerParticleVecInput m_vecPosOffset;
	float32 m_fDrag;
};
