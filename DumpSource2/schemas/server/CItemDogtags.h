// MNetworkVarNames = "CHandle<CCSPlayerPawn> m_OwningPlayer"
// MNetworkVarNames = "CHandle<CCSPlayerPawn> m_KillingPlayer"
class CItemDogtags : public CItem
{
	// MNetworkEnable
	CHandle< CCSPlayerPawn > m_OwningPlayer;
	// MNetworkEnable
	CHandle< CCSPlayerPawn > m_KillingPlayer;
};
