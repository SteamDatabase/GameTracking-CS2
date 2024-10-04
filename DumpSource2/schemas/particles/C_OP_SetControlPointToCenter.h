class C_OP_SetControlPointToCenter : public CParticleFunctionPreEmission
{
	int32 m_nCP1;
	Vector m_vecCP1Pos;
	bool m_bUseAvgParticlePos;
	ParticleParentSetMode_t m_nSetParent;
};
