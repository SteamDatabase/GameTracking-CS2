class CCSPlayerController_DamageServices : public CPlayerControllerComponent
{
	int32 m_nSendUpdate;
	CUtlVectorEmbeddedNetworkVar< CDamageRecord > m_DamageList;
};
