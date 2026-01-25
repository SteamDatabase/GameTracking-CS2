// MNetworkVarNames = "float m_flParticleSpacing"
// MNetworkVarNames = "float m_flSlack"
// MNetworkVarNames = "float m_flRadius"
// MNetworkVarNames = "Color m_ColorTint"
// MNetworkVarNames = "int m_nEffectState"
// MNetworkVarNames = "HParticleSystemDefinitionStrong m_iEffectIndex"
// MNetworkVarNames = "Vector m_PathNodes_Position"
// MNetworkVarNames = "Vector m_PathNodes_TangentIn"
// MNetworkVarNames = "Vector m_PathNodes_TangentOut"
// MNetworkVarNames = "Vector m_PathNodes_Color"
// MNetworkVarNames = "bool m_PathNodes_PinEnabled"
// MNetworkVarNames = "float m_PathNodes_RadiusScale"
class C_PathParticleRope : public C_BaseEntity
{
	bool m_bStartActive;
	float32 m_flMaxSimulationTime;
	CUtlSymbolLarge m_iszEffectName;
	CUtlVector< CUtlSymbolLarge > m_PathNodes_Name;
	// MNetworkEnable
	float32 m_flParticleSpacing;
	// MNetworkEnable
	// MNetworkChangeCallback = "parametersChanged"
	float32 m_flSlack;
	// MNetworkEnable
	// MNetworkChangeCallback = "parametersChanged"
	float32 m_flRadius;
	// MNetworkEnable
	// MNetworkChangeCallback = "parametersChanged"
	Color m_ColorTint;
	// MNetworkEnable
	// MNetworkChangeCallback = "effectStateChanged"
	int32 m_nEffectState;
	// MNetworkEnable
	// MNotSaved
	CStrongHandle< InfoForResourceTypeIParticleSystemDefinition > m_iEffectIndex;
	// MNetworkEnable
	C_NetworkUtlVectorBase< Vector > m_PathNodes_Position;
	// MNetworkEnable
	C_NetworkUtlVectorBase< Vector > m_PathNodes_TangentIn;
	// MNetworkEnable
	C_NetworkUtlVectorBase< Vector > m_PathNodes_TangentOut;
	// MNetworkEnable
	C_NetworkUtlVectorBase< Vector > m_PathNodes_Color;
	// MNetworkEnable
	// MNetworkChangeCallback = "pinStateChanged"
	C_NetworkUtlVectorBase< bool > m_PathNodes_PinEnabled;
	// MNetworkEnable
	C_NetworkUtlVectorBase< float32 > m_PathNodes_RadiusScale;
};
