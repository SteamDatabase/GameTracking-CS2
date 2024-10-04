class CSkyCamera : public CBaseEntity
{
	sky3dparams_t m_skyboxData;
	CUtlStringToken m_skyboxSlotToken;
	bool m_bUseAngles;
	CSkyCamera* m_pNext;
};
