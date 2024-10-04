class CPlayerSprayDecal : public CModelPointEntity
{
	int32 m_nUniqueID;
	uint32 m_unAccountID;
	uint32 m_unTraceID;
	uint32 m_rtGcTime;
	Vector m_vecEndPos;
	Vector m_vecStart;
	Vector m_vecLeft;
	Vector m_vecNormal;
	int32 m_nPlayer;
	int32 m_nEntity;
	int32 m_nHitbox;
	float32 m_flCreationTime;
	int32 m_nTintID;
	uint8 m_nVersion;
	uint8[128] m_ubSignature;
}
