// MNetworkVarNames = "CHandle< CPathNode > m_vecPathNodes"
// MNetworkVarNames = "CTransform m_xInitialPathWorldToLocal"
class CPathWithDynamicNodes : public CPathSimple
{
	// MNetworkEnable
	CNetworkUtlVectorBase< CHandle< CPathNode > > m_vecPathNodes;
	// MNetworkEnable
	CTransform m_xInitialPathWorldToLocal;
};
