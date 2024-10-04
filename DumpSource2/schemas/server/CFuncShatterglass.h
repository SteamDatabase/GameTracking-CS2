class CFuncShatterglass : public CBaseModelEntity
{
	matrix3x4_t m_matPanelTransform;
	matrix3x4_t m_matPanelTransformWsTemp;
	CUtlVector< uint32 > m_vecShatterGlassShards;
	Vector2D m_PanelSize;
	GameTime_t m_flLastShatterSoundEmitTime;
	GameTime_t m_flLastCleanupTime;
	GameTime_t m_flInitAtTime;
	float32 m_flGlassThickness;
	float32 m_flSpawnInvulnerability;
	bool m_bBreakSilent;
	bool m_bBreakShardless;
	bool m_bBroken;
	bool m_bGlassNavIgnore;
	bool m_bGlassInFrame;
	bool m_bStartBroken;
	uint8 m_iInitialDamageType;
	CUtlSymbolLarge m_szDamagePositioningEntityName01;
	CUtlSymbolLarge m_szDamagePositioningEntityName02;
	CUtlSymbolLarge m_szDamagePositioningEntityName03;
	CUtlSymbolLarge m_szDamagePositioningEntityName04;
	CUtlVector< Vector > m_vInitialDamagePositions;
	CUtlVector< Vector > m_vExtraDamagePositions;
	CUtlVector< Vector4D > m_vInitialPanelVertices;
	CEntityIOOutput m_OnBroken;
	uint8 m_iSurfaceType;
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_hMaterialDamageBase;
}
