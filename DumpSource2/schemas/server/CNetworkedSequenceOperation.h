// MNetworkVarNames = "HSequence m_hSequence"
// MNetworkVarNames = "float32 m_flPrevCycle"
// MNetworkVarNames = "float32 m_flCycle"
class CNetworkedSequenceOperation
{
	// MNetworkEnable
	// MNetworkSerializer = "minusone"
	// MNetworkChangeCallback = "sequenceOpSequenceChanged"
	// MNetworkPriority = 32
	HSequence m_hSequence;
	// MNetworkEnable
	// MNetworkBitCount = 15
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 1.000000
	// MNetworkEncodeFlags = 8
	// MNetworkPriority = 32
	// MNetworkSendProxyRecipientsFilter (UNKNOWN FOR PARSER)
	// MNetworkUserGroup = "m_flCycle"
	float32 m_flPrevCycle;
	// MNetworkEnable
	// MNetworkBitCount = 15
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 1.000000
	// MNetworkEncodeFlags = 8
	// MNetworkPriority = 32
	// MNetworkSendProxyRecipientsFilter (UNKNOWN FOR PARSER)
	// MNetworkUserGroup = "m_flCycle"
	float32 m_flCycle;
	// MNetworkEnable
	// MNetworkBitCount = 8
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 1.000000
	// MNetworkEncodeFlags = 0
	CNetworkedQuantizedFloat m_flWeight;
	// MNetworkDisable
	bool m_bSequenceChangeNetworked;
	// MNetworkDisable
	bool m_bDiscontinuity;
	// MNetworkDisable
	float32 m_flPrevCycleFromDiscontinuity;
	// MNetworkDisable
	float32 m_flPrevCycleForAnimEventDetection;
};
