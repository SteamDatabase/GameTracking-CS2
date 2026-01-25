// MNetworkVarNames = "Vector m_vInTangentLocal"
// MNetworkVarNames = "Vector m_vOutTangentLocal"
// MNetworkVarNames = "CUtlString m_strParentPathUniqueID"
// MNetworkVarNames = "CUtlString m_strPathNodeParameter"
class CPathNode : public CPointEntity
{
	// MNetworkEnable
	Vector m_vInTangentLocal;
	// MNetworkEnable
	Vector m_vOutTangentLocal;
	// MNetworkEnable
	CUtlString m_strParentPathUniqueID;
	// MNetworkEnable
	CUtlString m_strPathNodeParameter;
	CTransform m_xWSPrevParent;
	CHandle< CPathWithDynamicNodes > m_hPath;
};
