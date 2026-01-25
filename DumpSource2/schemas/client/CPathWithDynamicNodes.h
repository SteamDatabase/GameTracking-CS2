// MNetworkVarNames = "CHandle< CPathNode > m_vecPathNodes"
// MNetworkVarNames = "CTransform m_xInitialPathWorldToLocal"
class CPathWithDynamicNodes : public CPathSimple
{
	// MNetworkEnable
	C_NetworkUtlVectorBase< CHandle< CPathNode > > m_vecPathNodes;
	// MNetworkEnable
	CTransform m_xInitialPathWorldToLocal;
};
