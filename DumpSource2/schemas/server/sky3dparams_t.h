// MNetworkVarNames = "int16 scale"
// MNetworkVarNames = "Vector origin"
// MNetworkVarNames = "bool bClip3DSkyBoxNearToWorldFar"
// MNetworkVarNames = "float32 flClip3DSkyBoxNearToWorldFarOffset"
// MNetworkVarNames = "fogparams_t fog"
// MNetworkVarNames = "WorldGroupId_t m_nWorldGroupID"
class sky3dparams_t
{
	// MNetworkEnable
	int16 scale;
	// MNetworkEnable
	// MNetworkEncoder = "coord"
	Vector origin;
	// MNetworkEnable
	bool bClip3DSkyBoxNearToWorldFar;
	// MNetworkEnable
	float32 flClip3DSkyBoxNearToWorldFarOffset;
	// MNetworkEnable
	fogparams_t fog;
	// MNetworkEnable
	WorldGroupId_t m_nWorldGroupID;
};
