class CSosGroupActionSoundeventClusterSchema : public CSosGroupActionSchema
{
	int32 m_nMinNearby;
	float32 m_flClusterEpsilon;
	CUtlString m_shouldPlayOpvar;
	CUtlString m_shouldPlayClusterChild;
	CUtlString m_clusterSizeOpvar;
	CUtlString m_groupBoundingBoxMinsOpvar;
	CUtlString m_groupBoundingBoxMaxsOpvar;
};
