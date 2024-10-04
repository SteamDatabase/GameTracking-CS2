class FeSDFRigid_t
{
	Vector vLocalMin;
	Vector vLocalMax;
	float32 flBounciness;
	uint16 nNode;
	uint16 nCollisionMask;
	uint16 nVertexMapIndex;
	uint16 nFlags;
	CUtlVector< float32 > m_Distances;
	int32 m_nWidth;
	int32 m_nHeight;
	int32 m_nDepth;
};
