// MNetworkVarNames = "bool m_bSpotted"
// MNetworkVarNames = "uint32 m_bSpottedByMask"
class EntitySpottedState_t
{
	// MNetworkEnable
	// MNetworkChangeCallback = "OnIsSpottedChanged"
	bool m_bSpotted;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnIsSpottedChanged"
	uint32[2] m_bSpottedByMask;
};
