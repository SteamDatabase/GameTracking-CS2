class C_OP_MaintainSequentialPath : public CParticleFunctionOperator
{
	float32 m_fMaxDistance;
	float32 m_flNumToAssign;
	float32 m_flCohesionStrength;
	float32 m_flTolerance;
	bool m_bLoop;
	bool m_bUseParticleCount;
	CPathParameters m_PathParams;
};
