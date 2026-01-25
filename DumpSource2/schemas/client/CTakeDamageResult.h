class CTakeDamageResult
{
	// MNotSaved
	CTakeDamageInfo* m_pOriginatingInfo;
	int32 m_nHealthLost;
	int32 m_nHealthBefore;
	int32 m_nDamageDealt;
	float32 m_flPreModifiedDamage;
	int32 m_nTotalledHealthLost;
	int32 m_nTotalledDamageDealt;
	float32 m_flTotalledPreModifiedDamage;
	bool m_bWasDamageSuppressed;
	bool m_bSuppressFlinch;
	HitGroup_t m_nOverrideFlinchHitGroup;
};
