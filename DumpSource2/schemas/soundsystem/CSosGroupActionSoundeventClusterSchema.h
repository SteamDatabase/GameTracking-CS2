// MGetKV3ClassDefaults = {
//	"_class": "CSosGroupActionSoundeventClusterSchema",
//	"m_nMinNearby": 6,
//	"m_flClusterEpsilon": 36.000000,
//	"m_shouldPlayOpvar": "cluster_should_play",
//	"m_shouldPlayClusterChild": "cluster_should_play_child",
//	"m_clusterSizeOpvar": "cluster_size",
//	"m_groupBoundingBoxMinsOpvar": "cluster_group_box_mins",
//	"m_groupBoundingBoxMaxsOpvar": "cluster_group_box_maxs"
//}
// MPropertyFriendlyName = "Soundevent Cluster"
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
