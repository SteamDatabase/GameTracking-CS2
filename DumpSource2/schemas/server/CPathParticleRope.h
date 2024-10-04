class CPathParticleRope : public CBaseEntity
{
	bool m_bStartActive;
	float32 m_flMaxSimulationTime;
	CUtlSymbolLarge m_iszEffectName;
	CUtlVector< CUtlSymbolLarge > m_PathNodes_Name;
	float32 m_flParticleSpacing;
	float32 m_flSlack;
	float32 m_flRadius;
	Color m_ColorTint;
	int32 m_nEffectState;
	CStrongHandle< InfoForResourceTypeIParticleSystemDefinition > m_iEffectIndex;
	CNetworkUtlVectorBase< Vector > m_PathNodes_Position;
	CNetworkUtlVectorBase< Vector > m_PathNodes_TangentIn;
	CNetworkUtlVectorBase< Vector > m_PathNodes_TangentOut;
	CNetworkUtlVectorBase< Vector > m_PathNodes_Color;
	CNetworkUtlVectorBase< bool > m_PathNodes_PinEnabled;
	CNetworkUtlVectorBase< float32 > m_PathNodes_RadiusScale;
}
