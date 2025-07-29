class CBuoyancyHelper
{
	CUtlStringToken m_nFluidType;
	float32 m_flFluidDensity;
	float32 m_flNeutrallyBuoyantGravity;
	float32 m_flNeutrallyBuoyantLinearDamping;
	float32 m_flNeutrallyBuoyantAngularDamping;
	bool m_bNeutrallyBuoyant;
	CUtlVector< float32 > m_vecFractionOfWheelSubmergedForWheelFriction;
	CUtlVector< float32 > m_vecWheelFrictionScales;
	CUtlVector< float32 > m_vecFractionOfWheelSubmergedForWheelDrag;
	CUtlVector< float32 > m_vecWheelDrag;
};
