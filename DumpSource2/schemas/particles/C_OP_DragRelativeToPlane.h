class C_OP_DragRelativeToPlane : public CParticleFunctionOperator
{
	CParticleCollectionFloatInput m_flDragAtPlane;
	CParticleCollectionFloatInput m_flFalloff;
	bool m_bDirectional;
	CParticleCollectionVecInput m_vecPlaneNormal;
	int32 m_nControlPointNumber;
};
