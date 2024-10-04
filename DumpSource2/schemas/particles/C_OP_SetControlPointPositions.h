class C_OP_SetControlPointPositions : public CParticleFunctionPreEmission
{
	bool m_bUseWorldLocation;
	bool m_bOrient;
	bool m_bSetOnce;
	int32 m_nCP1;
	int32 m_nCP2;
	int32 m_nCP3;
	int32 m_nCP4;
	Vector m_vecCP1Pos;
	Vector m_vecCP2Pos;
	Vector m_vecCP3Pos;
	Vector m_vecCP4Pos;
	int32 m_nHeadLocation;
};
