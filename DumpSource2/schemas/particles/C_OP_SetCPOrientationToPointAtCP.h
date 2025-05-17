// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_SetCPOrientationToPointAtCP : public CParticleFunctionPreEmission
{
	// MPropertyFriendlyName = "CP to point towards"
	int32 m_nInputCP;
	// MPropertyFriendlyName = "CP to set"
	int32 m_nOutputCP;
	// MPropertyFriendlyName = "Interpolation"
	CParticleCollectionFloatInput m_flInterpolation;
	// MPropertyFriendlyName = "2D Orient"
	bool m_b2DOrientation;
	// MPropertyFriendlyName = "Avoid Vertical Axis Singularity"
	bool m_bAvoidSingularity;
	// MPropertyFriendlyName = "Point Away"
	bool m_bPointAway;
};
