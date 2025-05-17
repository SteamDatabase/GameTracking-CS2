// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_DragRelativeToPlane : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "dampening"
	CParticleCollectionFloatInput m_flDragAtPlane;
	// MPropertyFriendlyName = "falloff"
	CParticleCollectionFloatInput m_flFalloff;
	// MPropertyFriendlyName = "dampen on only one side of plane"
	bool m_bDirectional;
	// MPropertyFriendlyName = "plane normal"
	// MVectorIsCoordinate
	CParticleCollectionVecInput m_vecPlaneNormal;
	// MPropertyFriendlyName = "control point number"
	int32 m_nControlPointNumber;
};
