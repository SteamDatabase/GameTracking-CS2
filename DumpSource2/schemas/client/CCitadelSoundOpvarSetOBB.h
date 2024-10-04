class CCitadelSoundOpvarSetOBB : public C_BaseEntity
{
	CUtlSymbolLarge m_iszStackName;
	CUtlSymbolLarge m_iszOperatorName;
	CUtlSymbolLarge m_iszOpvarName;
	Vector m_vDistanceInnerMins;
	Vector m_vDistanceInnerMaxs;
	Vector m_vDistanceOuterMins;
	Vector m_vDistanceOuterMaxs;
	int32 m_nAABBDirection;
}
