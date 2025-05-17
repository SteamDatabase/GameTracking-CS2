// MNetworkVarNames = "Vector localSound"
// MNetworkVarNames = "int32 soundscapeIndex"
// MNetworkVarNames = "uint8 localBits"
// MNetworkVarNames = "int soundscapeEntityListIndex"
// MNetworkVarNames = "uint32 soundEventHash"
class audioparams_t
{
	// MNetworkEnable
	// MNetworkEncoder = "coord"
	Vector[8] localSound;
	// MNetworkEnable
	int32 soundscapeIndex;
	// MNetworkEnable
	uint8 localBits;
	// MNetworkEnable
	int32 soundscapeEntityListIndex;
	// MNetworkEnable
	uint32 soundEventHash;
};
