// MNetworkVarNames = "int m_nUniqueID"
// MNetworkVarNames = "uint32 m_unAccountID"
// MNetworkVarNames = "uint32 m_unTraceID"
// MNetworkVarNames = "uint32 m_rtGcTime"
// MNetworkVarNames = "Vector m_vecEndPos"
// MNetworkVarNames = "Vector m_vecStart"
// MNetworkVarNames = "Vector m_vecLeft"
// MNetworkVarNames = "Vector m_vecNormal"
// MNetworkVarNames = "int m_nPlayer"
// MNetworkVarNames = "int m_nEntity"
// MNetworkVarNames = "int m_nHitbox"
// MNetworkVarNames = "float m_flCreationTime"
// MNetworkVarNames = "int m_nTintID"
// MNetworkVarNames = "uint8 m_nVersion"
// MNetworkVarNames = "uint8 m_ubSignature"
class CPlayerSprayDecal : public CModelPointEntity
{
	// MNetworkEnable
	int32 m_nUniqueID;
	// MNetworkEnable
	uint32 m_unAccountID;
	// MNetworkEnable
	uint32 m_unTraceID;
	// MNetworkEnable
	uint32 m_rtGcTime;
	// MNetworkEnable
	Vector m_vecEndPos;
	// MNetworkEnable
	Vector m_vecStart;
	// MNetworkEnable
	Vector m_vecLeft;
	// MNetworkEnable
	Vector m_vecNormal;
	// MNetworkEnable
	int32 m_nPlayer;
	// MNetworkEnable
	int32 m_nEntity;
	// MNetworkEnable
	int32 m_nHitbox;
	// MNetworkEnable
	float32 m_flCreationTime;
	// MNetworkEnable
	int32 m_nTintID;
	// MNetworkEnable
	uint8 m_nVersion;
	// MNetworkEnable
	uint8[128] m_ubSignature;
};
