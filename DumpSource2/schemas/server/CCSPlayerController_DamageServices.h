class CCSPlayerController_DamageServices : public CPlayerControllerComponent
{
	CUtlVector< CDamageRecord > m_DamageListServer;
	int32 m_nSendUpdate;
	CUtlVectorEmbeddedNetworkVar< CDamageRecord > m_DamageList;
};
