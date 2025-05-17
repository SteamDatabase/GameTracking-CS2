// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RenderStandardLight : public CParticleFunctionRenderer
{
	// MPropertyFriendlyName = "light type"
	ParticleLightTypeChoiceList_t m_nLightType;
	// MPropertyFriendlyName = "color blend"
	CParticleCollectionVecInput m_vecColorScale;
	// MPropertyFriendlyName = "color blend type"
	ParticleColorBlendType_t m_nColorBlendType;
	// MPropertyFriendlyName = "intensity"
	CParticleCollectionFloatInput m_flIntensity;
	// MPropertyFriendlyName = "cast shadows"
	// MPropertySuppressExpr = "m_nLightType == PARTICLE_LIGHT_TYPE_FX"
	bool m_bCastShadows;
	// MPropertyFriendlyName = "inner cone angle"
	// MPropertySuppressExpr = "m_nLightType != PARTICLE_LIGHT_TYPE_SPOT"
	CParticleCollectionFloatInput m_flTheta;
	// MPropertyFriendlyName = "outer cone angle"
	// MPropertySuppressExpr = "m_nLightType != PARTICLE_LIGHT_TYPE_SPOT"
	CParticleCollectionFloatInput m_flPhi;
	// MPropertyFriendlyName = "light radius multiplier"
	CParticleCollectionFloatInput m_flRadiusMultiplier;
	// MPropertyFriendlyName = "attenuation type"
	StandardLightingAttenuationStyle_t m_nAttenuationStyle;
	// MPropertyFriendlyName = "falloff linearity"
	// MPropertySuppressExpr = "m_nAttenuationStyle == LIGHT_STYLE_NEW || ( m_nAttenuationStyle == LIGHT_STYLE_OLD && m_nLightType == PARTICLE_LIGHT_TYPE_FX )"
	CParticleCollectionFloatInput m_flFalloffLinearity;
	// MPropertyFriendlyName = "falloff fifty percent"
	// MPropertySuppressExpr = "m_nAttenuationStyle == LIGHT_STYLE_OLD"
	CParticleCollectionFloatInput m_flFiftyPercentFalloff;
	// MPropertyFriendlyName = "falloff zero percent"
	// MPropertySuppressExpr = "m_nAttenuationStyle == LIGHT_STYLE_OLD"
	CParticleCollectionFloatInput m_flZeroPercentFalloff;
	// MPropertyFriendlyName = "render diffuse"
	// MPropertySuppressExpr = "m_nLightType == PARTICLE_LIGHT_TYPE_FX"
	bool m_bRenderDiffuse;
	// MPropertyFriendlyName = "render specular"
	// MPropertySuppressExpr = "m_nLightType == PARTICLE_LIGHT_TYPE_FX"
	bool m_bRenderSpecular;
	// MPropertyFriendlyName = "light cookie string"
	CUtlString m_lightCookie;
	// MPropertyFriendlyName = "light priority"
	int32 m_nPriority;
	// MPropertyFriendlyName = "fog lighting mode"
	// MPropertySuppressExpr = "m_nLightType == PARTICLE_LIGHT_TYPE_FX"
	ParticleLightFogLightingMode_t m_nFogLightingMode;
	// MPropertyFriendlyName = "fog contribution"
	// MPropertySuppressExpr = "m_nLightType == PARTICLE_LIGHT_TYPE_FX"
	CParticleCollectionRendererFloatInput m_flFogContribution;
	// MPropertyFriendlyName = "capsule behavior"
	ParticleLightBehaviorChoiceList_t m_nCapsuleLightBehavior;
	// MPropertyStartGroup = "Capsule Light Controls"
	// MPropertyFriendlyName = "capsule length"
	// MPropertySuppressExpr = "m_nCapsuleLightBehavior == PARTICLE_LIGHT_BEHAVIOR_ROPE || m_nCapsuleLightBehavior == PARTICLE_LIGHT_BEHAVIOR_TRAILS"
	float32 m_flCapsuleLength;
	// MPropertyFriendlyName = "reverse point order"
	// MPropertySuppressExpr = "m_nCapsuleLightBehavior == PARTICLE_LIGHT_BEHAVIOR_FOLLOW_DIRECTION || m_nCapsuleLightBehavior == PARTICLE_LIGHT_BEHAVIOR_TRAILS"
	bool m_bReverseOrder;
	// MPropertyFriendlyName = "Closed loop"
	// MPropertySuppressExpr = "m_nCapsuleLightBehavior == PARTICLE_LIGHT_BEHAVIOR_FOLLOW_DIRECTION || m_nCapsuleLightBehavior == PARTICLE_LIGHT_BEHAVIOR_TRAILS"
	bool m_bClosedLoop;
	// MPropertyFriendlyName = "Anchor point source"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	// MPropertySuppressExpr = "m_nCapsuleLightBehavior == PARTICLE_LIGHT_BEHAVIOR_FOLLOW_DIRECTION || m_nCapsuleLightBehavior == PARTICLE_LIGHT_BEHAVIOR_ROPE"
	ParticleAttributeIndex_t m_nPrevPntSource;
	// MPropertyFriendlyName = "max length"
	// MPropertySuppressExpr = "m_nCapsuleLightBehavior == PARTICLE_LIGHT_BEHAVIOR_FOLLOW_DIRECTION || m_nCapsuleLightBehavior == PARTICLE_LIGHT_BEHAVIOR_ROPE"
	float32 m_flMaxLength;
	// MPropertyFriendlyName = "min length"
	// MPropertySuppressExpr = "m_nCapsuleLightBehavior == PARTICLE_LIGHT_BEHAVIOR_FOLLOW_DIRECTION || m_nCapsuleLightBehavior == PARTICLE_LIGHT_BEHAVIOR_ROPE"
	float32 m_flMinLength;
	// MPropertyFriendlyName = "ignore delta time"
	// MPropertySuppressExpr = "m_nCapsuleLightBehavior == PARTICLE_LIGHT_BEHAVIOR_FOLLOW_DIRECTION || m_nCapsuleLightBehavior == PARTICLE_LIGHT_BEHAVIOR_ROPE"
	bool m_bIgnoreDT;
	// MPropertyFriendlyName = "constrain radius to no more than this times the length"
	// MPropertySuppressExpr = "m_nCapsuleLightBehavior == PARTICLE_LIGHT_BEHAVIOR_FOLLOW_DIRECTION || m_nCapsuleLightBehavior == PARTICLE_LIGHT_BEHAVIOR_ROPE"
	float32 m_flConstrainRadiusToLengthRatio;
	// MPropertyFriendlyName = "amount to scale trail length by"
	// MPropertySuppressExpr = "m_nCapsuleLightBehavior == PARTICLE_LIGHT_BEHAVIOR_FOLLOW_DIRECTION || m_nCapsuleLightBehavior == PARTICLE_LIGHT_BEHAVIOR_ROPE"
	float32 m_flLengthScale;
	// MPropertyFriendlyName = "how long before a trail grows to its full length"
	// MPropertySuppressExpr = "m_nCapsuleLightBehavior == PARTICLE_LIGHT_BEHAVIOR_FOLLOW_DIRECTION || m_nCapsuleLightBehavior == PARTICLE_LIGHT_BEHAVIOR_ROPE"
	float32 m_flLengthFadeInTime;
};
