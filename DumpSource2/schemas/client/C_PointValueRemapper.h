// MNetworkVarNames = "bool m_bDisabled"
// MNetworkVarNames = "bool m_bUpdateOnClient"
// MNetworkVarNames = "ValueRemapperInputType_t m_nInputType"
// MNetworkVarNames = "CHandle< CBaseEntity> m_hRemapLineStart"
// MNetworkVarNames = "CHandle< CBaseEntity> m_hRemapLineEnd"
// MNetworkVarNames = "float m_flMaximumChangePerSecond"
// MNetworkVarNames = "float m_flDisengageDistance"
// MNetworkVarNames = "float m_flEngageDistance"
// MNetworkVarNames = "bool m_bRequiresUseKey"
// MNetworkVarNames = "ValueRemapperOutputType_t m_nOutputType"
// MNetworkVarNames = "CHandle< C_BaseEntity > m_hOutputEntities"
// MNetworkVarNames = "ValueRemapperHapticsType_t m_nHapticsType"
// MNetworkVarNames = "ValueRemapperMomentumType_t m_nMomentumType"
// MNetworkVarNames = "float m_flMomentumModifier"
// MNetworkVarNames = "float m_flSnapValue"
// MNetworkVarNames = "ValueRemapperRatchetType_t m_nRatchetType"
// MNetworkVarNames = "float m_flInputOffset"
class C_PointValueRemapper : public C_BaseEntity
{
	// MNetworkEnable
	bool m_bDisabled;
	bool m_bDisabledOld;
	// MNetworkEnable
	bool m_bUpdateOnClient;
	// MNetworkEnable
	ValueRemapperInputType_t m_nInputType;
	// MNetworkEnable
	CHandle< C_BaseEntity > m_hRemapLineStart;
	// MNetworkEnable
	CHandle< C_BaseEntity > m_hRemapLineEnd;
	// MNetworkEnable
	float32 m_flMaximumChangePerSecond;
	// MNetworkEnable
	float32 m_flDisengageDistance;
	// MNetworkEnable
	float32 m_flEngageDistance;
	// MNetworkEnable
	bool m_bRequiresUseKey;
	// MNetworkEnable
	ValueRemapperOutputType_t m_nOutputType;
	// MNetworkEnable
	// MNotSaved
	C_NetworkUtlVectorBase< CHandle< C_BaseEntity > > m_hOutputEntities;
	// MNetworkEnable
	ValueRemapperHapticsType_t m_nHapticsType;
	// MNetworkEnable
	ValueRemapperMomentumType_t m_nMomentumType;
	// MNetworkEnable
	float32 m_flMomentumModifier;
	// MNetworkEnable
	float32 m_flSnapValue;
	float32 m_flCurrentMomentum;
	// MNetworkEnable
	ValueRemapperRatchetType_t m_nRatchetType;
	float32 m_flRatchetOffset;
	// MNetworkEnable
	float32 m_flInputOffset;
	bool m_bEngaged;
	bool m_bFirstUpdate;
	float32 m_flPreviousValue;
	GameTime_t m_flPreviousUpdateTickTime;
	Vector m_vecPreviousTestPoint;
};
