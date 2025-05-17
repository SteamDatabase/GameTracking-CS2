// MNetworkExcludeByName = "m_hModel"
// MNetworkVarNames = "shard_model_desc_t m_ShardDesc"
class CShatterGlassShardPhysics : public CPhysicsProp
{
	bool m_bDebris;
	uint32 m_hParentShard;
	// MNetworkEnable
	shard_model_desc_t m_ShardDesc;
};
