class C_PointValueRemapper : public C_BaseEntity
{
	bool m_bDisabled;
	bool m_bDisabledOld;
	bool m_bUpdateOnClient;
	ValueRemapperInputType_t m_nInputType;
	CHandle< C_BaseEntity > m_hRemapLineStart;
	CHandle< C_BaseEntity > m_hRemapLineEnd;
	float32 m_flMaximumChangePerSecond;
	float32 m_flDisengageDistance;
	float32 m_flEngageDistance;
	bool m_bRequiresUseKey;
	ValueRemapperOutputType_t m_nOutputType;
	C_NetworkUtlVectorBase< CHandle< C_BaseEntity > > m_hOutputEntities;
	ValueRemapperHapticsType_t m_nHapticsType;
	ValueRemapperMomentumType_t m_nMomentumType;
	float32 m_flMomentumModifier;
	float32 m_flSnapValue;
	float32 m_flCurrentMomentum;
	ValueRemapperRatchetType_t m_nRatchetType;
	float32 m_flRatchetOffset;
	float32 m_flInputOffset;
	bool m_bEngaged;
	bool m_bFirstUpdate;
	float32 m_flPreviousValue;
	GameTime_t m_flPreviousUpdateTickTime;
	Vector m_vecPreviousTestPoint;
}
