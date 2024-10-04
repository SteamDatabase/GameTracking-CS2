class C_INIT_CreateSequentialPath : public CParticleFunctionInitializer
{
	float32 m_fMaxDistance;
	float32 m_flNumToAssign;
	bool m_bLoop;
	bool m_bCPPairs;
	bool m_bSaveOffset;
	CPathParameters m_PathParams;
};
