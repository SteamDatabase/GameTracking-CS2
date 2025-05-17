// MNetworkVarNames = "SellbackPurchaseEntry_t m_vecSellbackPurchaseEntries"
class CCSPlayer_BuyServices : public CPlayerPawnComponent
{
	// MNetworkEnable
	CUtlVectorEmbeddedNetworkVar< SellbackPurchaseEntry_t > m_vecSellbackPurchaseEntries;
};
