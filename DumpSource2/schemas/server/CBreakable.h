// MNetworkVarNames = "CPropDataComponent::Storage_t m_CPropDataComponent"
class CBreakable : public CBaseModelEntity
{
	// MNetworkEnable
	// MNetworkUserGroup = "CPropDataComponent"
	// MNetworkAlias = "CPropDataComponent"
	// MNetworkTypeAlias = "CPropDataComponent"
	CPropDataComponent m_CPropDataComponent;
	Materials m_Material;
	CHandle< CBaseEntity > m_hBreaker;
	Explosions m_Explosion;
	CUtlSymbolLarge m_iszSpawnObject;
	float32 m_flPressureDelay;
	int32 m_iMinHealthDmg;
	CUtlSymbolLarge m_iszPropData;
	float32 m_impactEnergyScale;
	EOverrideBlockLOS_t m_nOverrideBlockLOS;
	CEntityIOOutput m_OnBreak;
	CEntityOutputTemplate< float32 > m_OnHealthChanged;
	PerformanceMode_t m_PerformanceMode;
	CHandle< CBasePlayerPawn > m_hPhysicsAttacker;
	GameTime_t m_flLastPhysicsInfluenceTime;
};
