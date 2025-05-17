// MNetworkVarNames = "CHandle<CCSPlayerPawn> m_OwningPlayer"
// MNetworkVarNames = "CHandle<CCSPlayerPawn> m_KillingPlayer"
class C_ItemDogtags : public C_Item
{
	// MNetworkEnable
	CHandle< C_CSPlayerPawn > m_OwningPlayer;
	// MNetworkEnable
	CHandle< C_CSPlayerPawn > m_KillingPlayer;
};
