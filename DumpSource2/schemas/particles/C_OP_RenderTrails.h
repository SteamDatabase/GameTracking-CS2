// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RenderTrails : public CBaseTrailRenderer
{
	// MPropertyStartGroup = "Screenspace Fading and culling"
	// MPropertyFriendlyName = "enable fading and clamping"
	// MPropertySortPriority = 1000
	bool m_bEnableFadingAndClamping;
	// MPropertyFriendlyName = "start fade dot product of normal vs view"
	// MPropertySortPriority = 1000
	float32 m_flStartFadeDot;
	// MPropertyFriendlyName = "end fade dot product of normal vs view"
	// MPropertySortPriority = 1000
	float32 m_flEndFadeDot;
	// MPropertyStartGroup = "+Trail Length"
	// MPropertyFriendlyName = "Anchor point source"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	// MPropertySortPriority = 800
	ParticleAttributeIndex_t m_nPrevPntSource;
	// MPropertyFriendlyName = "max length"
	// MPropertySortPriority = 800
	float32 m_flMaxLength;
	// MPropertyFriendlyName = "min length"
	// MPropertySortPriority = 800
	float32 m_flMinLength;
	// MPropertyFriendlyName = "ignore delta time"
	// MPropertySortPriority = 800
	bool m_bIgnoreDT;
	// MPropertyFriendlyName = "constrain radius to no more than this times the length"
	// MPropertySortPriority = 800
	float32 m_flConstrainRadiusToLengthRatio;
	// MPropertyFriendlyName = "amount to scale trail length by"
	float32 m_flLengthScale;
	// MPropertyFriendlyName = "how long before a trail grows to its full length"
	float32 m_flLengthFadeInTime;
	// MPropertyStartGroup = "Trail Head & Tail"
	// MPropertyFriendlyName = "head taper scale"
	// MPropertySortPriority = 800
	CPerParticleFloatInput m_flRadiusHeadTaper;
	// MPropertyFriendlyName = "head color scale"
	CParticleCollectionVecInput m_vecHeadColorScale;
	// MPropertyFriendlyName = "head alpha scale"
	CPerParticleFloatInput m_flHeadAlphaScale;
	// MPropertyFriendlyName = "tail taper scale"
	CPerParticleFloatInput m_flRadiusTaper;
	// MPropertyFriendlyName = "tail color scale"
	CParticleCollectionVecInput m_vecTailColorScale;
	// MPropertyFriendlyName = "tail alpha scale"
	CPerParticleFloatInput m_flTailAlphaScale;
	// MPropertyStartGroup = "Trail UV Controls"
	// MPropertyFriendlyName = "texture UV horizontal Scale field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	// MPropertySortPriority = 800
	ParticleAttributeIndex_t m_nHorizCropField;
	// MPropertyFriendlyName = "texture UV vertical Scale field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nVertCropField;
	// MPropertyFriendlyName = "Trail forward shift (fraction)"
	float32 m_flForwardShift;
	// MPropertyFriendlyName = "Flip U or V texcoords if pitch or yaw go over PI"
	bool m_bFlipUVBasedOnPitchYaw;
};
