// MGetKV3ClassDefaults = {
//	"_class": "CParticleSystemDefinition",
//	"m_nBehaviorVersion": 0,
//	"m_PreEmissionOperators":
//	[
//	],
//	"m_Emitters":
//	[
//	],
//	"m_Initializers":
//	[
//	],
//	"m_Operators":
//	[
//	],
//	"m_ForceGenerators":
//	[
//	],
//	"m_Constraints":
//	[
//	],
//	"m_Renderers":
//	[
//	],
//	"m_Children":
//	[
//	],
//	"m_nFirstMultipleOverride_BackwardCompat": -1,
//	"m_nInitialParticles": 0,
//	"m_nMaxParticles": 1000,
//	"m_nGroupID": 0,
//	"m_BoundingBoxMin":
//	[
//		-10.000000,
//		-10.000000,
//		-10.000000
//	],
//	"m_BoundingBoxMax":
//	[
//		10.000000,
//		10.000000,
//		10.000000
//	],
//	"m_flDepthSortBias": 0.000000,
//	"m_nSortOverridePositionCP": -1,
//	"m_bInfiniteBounds": false,
//	"m_bEnableNamedValues": false,
//	"m_NamedValueDomain": "",
//	"m_NamedValueLocals":
//	[
//	],
//	"m_ConstantColor":
//	[
//		255,
//		255,
//		255
//	],
//	"m_ConstantNormal":
//	[
//		0.000000,
//		0.000000,
//		1.000000
//	],
//	"m_flConstantRadius": 5.000000,
//	"m_flConstantRotation": 0.000000,
//	"m_flConstantRotationSpeed": 0.000000,
//	"m_flConstantLifespan": 1.000000,
//	"m_nConstantSequenceNumber": 0,
//	"m_nConstantSequenceNumber1": 0,
//	"m_nSnapshotControlPoint": 0,
//	"m_hSnapshot": "",
//	"m_pszCullReplacementName": "",
//	"m_flCullRadius": 0.000000,
//	"m_flCullFillCost": 1.000000,
//	"m_nCullControlPoint": 0,
//	"m_hFallback": "",
//	"m_nFallbackMaxCount": -1,
//	"m_hLowViolenceDef": "",
//	"m_hReferenceReplacement": "",
//	"m_flPreSimulationTime": 0.000000,
//	"m_flStopSimulationAfterTime": 1000000000.000000,
//	"m_flMaximumTimeStep": 0.100000,
//	"m_flMaximumSimTime": 0.000000,
//	"m_flMinimumSimTime": 0.000000,
//	"m_flMinimumTimeStep": 0.000000,
//	"m_nMinimumFrames": 0,
//	"m_nMinCPULevel": 0,
//	"m_nMinGPULevel": 0,
//	"m_flNoDrawTimeToGoToSleep": 8.000000,
//	"m_flMaxDrawDistance": -1.000000,
//	"m_flStartFadeDistance": 200000.000000,
//	"m_flMaxCreationDistance": -1.000000,
//	"m_nAggregationMinAvailableParticles": 1,
//	"m_flAggregateRadius": 0.000000,
//	"m_bShouldBatch": false,
//	"m_bShouldHitboxesFallbackToRenderBounds": true,
//	"m_bShouldHitboxesFallbackToSnapshot": true,
//	"m_bShouldHitboxesFallbackToCollisionHulls": true,
//	"m_nViewModelEffect": "INHERITABLE_BOOL_INHERIT",
//	"m_bScreenSpaceEffect": false,
//	"m_pszTargetLayerID": "",
//	"m_nSkipRenderControlPoint": -1,
//	"m_nAllowRenderControlPoint": -1,
//	"m_bShouldSort": true,
//	"m_controlPointConfigurations":
//	[
//	]
//}
class CParticleSystemDefinition : public IParticleSystemDefinition
{
	// MPropertyFriendlyName = "version"
	// MPropertySuppressField
	int32 m_nBehaviorVersion;
	// MPropertySuppressField
	CUtlVector< CParticleFunctionPreEmission* > m_PreEmissionOperators;
	// MPropertySuppressField
	CUtlVector< CParticleFunctionEmitter* > m_Emitters;
	// MPropertySuppressField
	CUtlVector< CParticleFunctionInitializer* > m_Initializers;
	// MPropertySuppressField
	CUtlVector< CParticleFunctionOperator* > m_Operators;
	// MPropertySuppressField
	CUtlVector< CParticleFunctionForce* > m_ForceGenerators;
	// MPropertySuppressField
	CUtlVector< CParticleFunctionConstraint* > m_Constraints;
	// MPropertySuppressField
	CUtlVector< CParticleFunctionRenderer* > m_Renderers;
	// MPropertySuppressField
	CUtlVector< ParticleChildrenInfo_t > m_Children;
	// MPropertySuppressField
	int32 m_nFirstMultipleOverride_BackwardCompat;
	// MPropertyStartGroup = "+Collection Options"
	// MPropertyFriendlyName = "initial particles"
	int32 m_nInitialParticles;
	// MPropertyFriendlyName = "max particles"
	int32 m_nMaxParticles;
	// MPropertyFriendlyName = "group id"
	int32 m_nGroupID;
	// MPropertyStartGroup = "Bounding Box"
	// MPropertyFriendlyName = "bounding box bloat min"
	// MVectorIsCoordinate
	Vector m_BoundingBoxMin;
	// MPropertyFriendlyName = "bounding box bloat max"
	// MVectorIsCoordinate
	Vector m_BoundingBoxMax;
	// MPropertyFriendlyName = "bounding box depth sort bias"
	float32 m_flDepthSortBias;
	// MPropertyFriendlyName = "sort override position CP"
	int32 m_nSortOverridePositionCP;
	// MPropertyFriendlyName = "infinite bounds - don't cull"
	bool m_bInfiniteBounds;
	// MPropertyStartGroup = "Named Values"
	// MPropertyFriendlyName = "Enable Named Values (EXPERIMENTAL)"
	bool m_bEnableNamedValues;
	// MPropertyFriendlyName = "Domain Class"
	// MPropertyAttributeChoiceName = "particlefield_domain"
	// MPropertyAutoRebuildOnChange
	// MPropertySuppressExpr = "!m_bEnableNamedValues"
	CUtlString m_NamedValueDomain;
	// MPropertySuppressField
	CUtlVector< ParticleNamedValueSource_t* > m_NamedValueLocals;
	// MPropertyStartGroup = "+Base Properties"
	// MPropertyFriendlyName = "color"
	// MPropertyColorPlusAlpha
	Color m_ConstantColor;
	// MPropertyFriendlyName = "normal"
	// MVectorIsCoordinate
	Vector m_ConstantNormal;
	// MPropertyFriendlyName = "radius"
	// MPropertyAttributeRange = "biased 0 500"
	float32 m_flConstantRadius;
	// MPropertyFriendlyName = "rotation"
	float32 m_flConstantRotation;
	// MPropertyFriendlyName = "rotation speed"
	float32 m_flConstantRotationSpeed;
	// MPropertyFriendlyName = "lifetime"
	float32 m_flConstantLifespan;
	// MPropertyFriendlyName = "sequence number"
	// MPropertyAttributeEditor = "SequencePicker( 1 )"
	int32 m_nConstantSequenceNumber;
	// MPropertyFriendlyName = "sequence number 1"
	// MPropertyAttributeEditor = "SequencePicker( 2 )"
	int32 m_nConstantSequenceNumber1;
	// MPropertyStartGroup = "Snapshot Options"
	int32 m_nSnapshotControlPoint;
	CStrongHandle< InfoForResourceTypeIParticleSnapshot > m_hSnapshot;
	// MPropertyStartGroup = "Replacement Options"
	// MPropertyFriendlyName = "cull replacement definition"
	CStrongHandle< InfoForResourceTypeIParticleSystemDefinition > m_pszCullReplacementName;
	// MPropertyFriendlyName = "cull radius"
	float32 m_flCullRadius;
	// MPropertyFriendlyName = "cull cost"
	float32 m_flCullFillCost;
	// MPropertyFriendlyName = "cull control point"
	int32 m_nCullControlPoint;
	// MPropertyFriendlyName = "fallback replacement definition"
	CStrongHandle< InfoForResourceTypeIParticleSystemDefinition > m_hFallback;
	// MPropertyFriendlyName = "fallback max count"
	int32 m_nFallbackMaxCount;
	// MPropertyFriendlyName = "low violence definition"
	CStrongHandle< InfoForResourceTypeIParticleSystemDefinition > m_hLowViolenceDef;
	// MPropertyFriendlyName = "reference replacement definition"
	CStrongHandle< InfoForResourceTypeIParticleSystemDefinition > m_hReferenceReplacement;
	// MPropertyStartGroup = "Simulation Options"
	// MPropertyFriendlyName = "pre-simulation time"
	float32 m_flPreSimulationTime;
	// MPropertyFriendlyName = "freeze simulation after time"
	float32 m_flStopSimulationAfterTime;
	// MPropertyFriendlyName = "maximum time step"
	float32 m_flMaximumTimeStep;
	// MPropertyFriendlyName = "maximum sim tick rate"
	float32 m_flMaximumSimTime;
	// MPropertyFriendlyName = "minimum sim tick rate"
	float32 m_flMinimumSimTime;
	// MPropertyFriendlyName = "minimum simulation time step"
	float32 m_flMinimumTimeStep;
	// MPropertyFriendlyName = "minimum required rendered frames"
	int32 m_nMinimumFrames;
	// MPropertyStartGroup = "Performance Options"
	// MPropertyFriendlyName = "minimum CPU level"
	int32 m_nMinCPULevel;
	// MPropertyFriendlyName = "minimum GPU level"
	int32 m_nMinGPULevel;
	// MPropertyFriendlyName = "time to sleep when not drawn"
	float32 m_flNoDrawTimeToGoToSleep;
	// MPropertyFriendlyName = "maximum draw distance"
	float32 m_flMaxDrawDistance;
	// MPropertyFriendlyName = "start fade distance"
	float32 m_flStartFadeDistance;
	// MPropertyFriendlyName = "maximum creation distance"
	float32 m_flMaxCreationDistance;
	// MPropertyFriendlyName = "minimum free particles to aggregate"
	int32 m_nAggregationMinAvailableParticles;
	// MPropertyFriendlyName = "aggregation radius"
	float32 m_flAggregateRadius;
	// MPropertyFriendlyName = "batch particle systems (DO NOT USE)"
	// MParticleAdvancedField
	bool m_bShouldBatch;
	// MPropertyFriendlyName = "Hitboxes fall back to render bounds"
	bool m_bShouldHitboxesFallbackToRenderBounds;
	// MPropertyFriendlyName = "Hitboxes fall back to snapshot"
	bool m_bShouldHitboxesFallbackToSnapshot;
	// MPropertyFriendlyName = "Hitboxes fall back to collision hulls"
	bool m_bShouldHitboxesFallbackToCollisionHulls;
	// MPropertyStartGroup = "Rendering Options"
	// MPropertyFriendlyName = "view model effect"
	// MPropertySuppressExpr = "m_bScreenSpaceEffect"
	InheritableBoolType_t m_nViewModelEffect;
	// MPropertyFriendlyName = "screen space effect"
	// MPropertySuppressExpr = "m_nViewModelEffect == INHERITABLE_BOOL_TRUE"
	bool m_bScreenSpaceEffect;
	// MPropertyFriendlyName = "target layer ID for rendering"
	CUtlSymbolLarge m_pszTargetLayerID;
	// MPropertyFriendlyName = "control point to disable rendering if it is the camera"
	int32 m_nSkipRenderControlPoint;
	// MPropertyFriendlyName = "control point to only enable rendering if it is the camera"
	int32 m_nAllowRenderControlPoint;
	// MPropertyFriendlyName = "sort particles (DEPRECATED - USE RENDERER OPTION)"
	// MParticleAdvancedField
	bool m_bShouldSort;
	// MPropertySuppressField
	CUtlVector< ParticleControlPointConfiguration_t > m_controlPointConfigurations;
};
