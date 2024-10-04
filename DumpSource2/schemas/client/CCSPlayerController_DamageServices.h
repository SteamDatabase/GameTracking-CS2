class CCSPlayerController_DamageServices : public CPlayerControllerComponent
{
	int32 m_nSendUpdate;
	C_UtlVectorEmbeddedNetworkVar< CDamageRecord > m_DamageList;
};
