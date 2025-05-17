// MNetworkIncludeByUserGroup = "Origin"
// MNetworkIncludeByName = "CGameSceneNode::m_angRotation"
// MNetworkIncludeByName = "m_hOwnerEntity"
// MNetworkIncludeByName = "CGameSceneNode::m_hParent"
// MNetworkIncludeByName = "CGameSceneNode::m_hierarchyAttachName"
// MNetworkIncludeByName = "m_nameStringableIndex"
// MEntityAllowsPortraitWorldSpawn
// MNetworkVarNames = "char m_szSnapshotFileName"
// MNetworkVarNames = "bool m_bActive"
// MNetworkVarNames = "bool m_bFrozen"
// MNetworkVarNames = "float m_flFreezeTransitionDuration"
// MNetworkVarNames = "int m_nStopType"
// MNetworkVarNames = "bool m_bAnimateDuringGameplayPause"
// MNetworkVarNames = "HParticleSystemDefinitionStrong m_iEffectIndex"
// MNetworkVarNames = "GameTime_t m_flStartTime"
// MNetworkVarNames = "float32 m_flPreSimTime"
// MNetworkVarNames = "Vector m_vServerControlPoints"
// MNetworkVarNames = "uint8 m_iServerControlPointAssignments"
// MNetworkVarNames = "CHandle< CBaseEntity > m_hControlPointEnts"
// MNetworkVarNames = "bool m_bNoSave"
// MNetworkVarNames = "bool m_bNoFreeze"
// MNetworkVarNames = "bool m_bNoRamp"
class C_ParticleSystem : public C_BaseModelEntity
{
	// MNetworkEnable
	char[512] m_szSnapshotFileName;
	// MNetworkEnable
	bool m_bActive;
	// MNetworkEnable
	bool m_bFrozen;
	// MNetworkEnable
	float32 m_flFreezeTransitionDuration;
	// MNetworkEnable
	int32 m_nStopType;
	// MNetworkEnable
	bool m_bAnimateDuringGameplayPause;
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeIParticleSystemDefinition > m_iEffectIndex;
	// MNetworkEnable
	GameTime_t m_flStartTime;
	// MNetworkEnable
	float32 m_flPreSimTime;
	// MNetworkEnable
	Vector[4] m_vServerControlPoints;
	// MNetworkEnable
	uint8[4] m_iServerControlPointAssignments;
	// MNetworkEnable
	CHandle< C_BaseEntity >[64] m_hControlPointEnts;
	// MNetworkEnable
	bool m_bNoSave;
	// MNetworkEnable
	bool m_bNoFreeze;
	// MNetworkEnable
	bool m_bNoRamp;
	bool m_bStartActive;
	CUtlSymbolLarge m_iszEffectName;
	CUtlSymbolLarge[64] m_iszControlPointNames;
	int32 m_nDataCP;
	Vector m_vecDataCPValue;
	int32 m_nTintCP;
	Color m_clrTint;
	bool m_bOldActive;
	bool m_bOldFrozen;
};
