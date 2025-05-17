// MNetworkVarNames = "SellbackPurchaseEntry_t m_vecSellbackPurchaseEntries"
class CCSPlayer_BuyServices : public CPlayerPawnComponent
{
	// MNetworkEnable
	C_UtlVectorEmbeddedNetworkVar< SellbackPurchaseEntry_t > m_vecSellbackPurchaseEntries;
};
