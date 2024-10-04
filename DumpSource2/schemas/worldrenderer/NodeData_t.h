class NodeData_t
{
	int32 m_nParent;
	Vector m_vOrigin;
	Vector m_vMinBounds;
	Vector m_vMaxBounds;
	float32 m_flMinimumDistance;
	CUtlVector< int32 > m_ChildNodeIndices;
	CUtlString m_worldNodePrefix;
};
