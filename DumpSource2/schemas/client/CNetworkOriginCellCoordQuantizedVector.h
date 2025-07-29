// MNetworkVarsAtomic
class CNetworkOriginCellCoordQuantizedVector
{
	// MNetworkEnable
	// MNetworkChangeCallback = "OnCellChanged"
	// MNetworkPriority = 31
	// MNetworkSerializer = "cellx"
	uint16 m_cellX;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnCellChanged"
	// MNetworkPriority = 31
	// MNetworkSerializer = "celly"
	uint16 m_cellY;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnCellChanged"
	// MNetworkPriority = 31
	// MNetworkSerializer = "cellz"
	uint16 m_cellZ;
	// MNetworkEnable
	uint16 m_nOutsideWorld;
	// MNetworkEnable
	// MNetworkBitCount = 15
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 1024.000000
	// MNetworkEncodeFlags = 1
	// MNetworkChangeCallback = "OnCellChanged"
	// MNetworkPriority = 31
	// MNetworkSerializer = "posx"
	CNetworkedQuantizedFloat m_vecX;
	// MNetworkEnable
	// MNetworkBitCount = 15
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 1024.000000
	// MNetworkEncodeFlags = 1
	// MNetworkChangeCallback = "OnCellChanged"
	// MNetworkPriority = 31
	// MNetworkSerializer = "posy"
	CNetworkedQuantizedFloat m_vecY;
	// MNetworkEnable
	// MNetworkBitCount = 15
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 1024.000000
	// MNetworkEncodeFlags = 1
	// MNetworkChangeCallback = "OnCellChanged"
	// MNetworkPriority = 31
	// MNetworkSerializer = "posz"
	CNetworkedQuantizedFloat m_vecZ;
};
