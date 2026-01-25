// MNetworkVarNames = "sky3dparams_t m_skyboxData"
// MNetworkVarNames = "CUtlStringToken m_skyboxSlotToken"
class CSkyCamera : public CBaseEntity
{
	// MNetworkEnable
	// MNotSaved
	sky3dparams_t m_skyboxData;
	// MNetworkEnable
	CUtlStringToken m_skyboxSlotToken;
	bool m_bUseAngles;
	// MNotSaved
	CSkyCamera* m_pNext;
};
