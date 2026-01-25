// MNetworkVarNames = "sky3dparams_t m_skyboxData"
// MNetworkVarNames = "CUtlStringToken m_skyboxSlotToken"
class C_SkyCamera : public C_BaseEntity
{
	// MNetworkEnable
	// MNotSaved
	sky3dparams_t m_skyboxData;
	// MNetworkEnable
	CUtlStringToken m_skyboxSlotToken;
	bool m_bUseAngles;
	// MNotSaved
	C_SkyCamera* m_pNext;
};
