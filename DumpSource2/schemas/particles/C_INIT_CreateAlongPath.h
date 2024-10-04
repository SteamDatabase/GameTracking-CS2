class C_INIT_CreateAlongPath : public CParticleFunctionInitializer
{
	float32 m_fMaxDistance;
	CPathParameters m_PathParams;
	bool m_bUseRandomCPs;
	Vector m_vEndOffset;
	bool m_bSaveOffset;
};
