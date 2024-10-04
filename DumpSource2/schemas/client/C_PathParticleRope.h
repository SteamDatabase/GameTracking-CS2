class C_PathParticleRope : public C_BaseEntity
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
	C_NetworkUtlVectorBase< Vector > m_PathNodes_Position;
	C_NetworkUtlVectorBase< Vector > m_PathNodes_TangentIn;
	C_NetworkUtlVectorBase< Vector > m_PathNodes_TangentOut;
	C_NetworkUtlVectorBase< Vector > m_PathNodes_Color;
	C_NetworkUtlVectorBase< bool > m_PathNodes_PinEnabled;
	C_NetworkUtlVectorBase< float32 > m_PathNodes_RadiusScale;
}
