// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CSosGroupActionSoundeventClusterSchema : public CSosGroupActionSchema
{
	// MPropertyFriendlyName = "Minimum Nearby Soundevents"
	int32 m_nMinNearby;
	// MPropertyFriendlyName = "Search Radius to Cluster Soundevents"
	float32 m_flClusterEpsilon;
	// MPropertyFriendlyName = "'Should Play' Opvar Name"
	CUtlString m_shouldPlayOpvar;
	// MPropertyFriendlyName = "'Should Play Cluster Child' Opvar Name"
	CUtlString m_shouldPlayClusterChild;
	// MPropertyFriendlyName = "Cluster Size Opvar Name"
	CUtlString m_clusterSizeOpvar;
	// MPropertyFriendlyName = "'Group Box Mins' Opvar Name"
	CUtlString m_groupBoundingBoxMinsOpvar;
	// MPropertyFriendlyName = "'Group Box Maxs' Opvar Name"
	CUtlString m_groupBoundingBoxMaxsOpvar;
};
