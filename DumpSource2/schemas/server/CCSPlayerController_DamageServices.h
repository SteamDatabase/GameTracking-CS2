// MNetworkVarNames = "int m_nSendUpdate"
// MNetworkVarNames = "CDamageRecord m_DamageList"
// MNetworkReplayCompatField = "m_DamageList.*"
class CCSPlayerController_DamageServices : public CPlayerControllerComponent
{
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusiveDuringRoundEnd"
	// MNetworkChangeCallback = "OnDamageListUpdate"
	int32 m_nSendUpdate;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusiveDuringRoundEnd"
	CUtlVectorEmbeddedNetworkVar< CDamageRecord > m_DamageList;
};
