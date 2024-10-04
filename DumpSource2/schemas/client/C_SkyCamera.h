class C_SkyCamera : public C_BaseEntity
{
	sky3dparams_t m_skyboxData;
	CUtlStringToken m_skyboxSlotToken;
	bool m_bUseAngles;
	C_SkyCamera* m_pNext;
};
