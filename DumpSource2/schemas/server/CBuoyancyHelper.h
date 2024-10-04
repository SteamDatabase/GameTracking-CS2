class CBuoyancyHelper
{
	CUtlStringToken m_nFluidType;
	float32 m_flFluidDensity;
	CUtlVector< float32 > m_vecFractionOfWheelSubmergedForWheelFriction;
	CUtlVector< float32 > m_vecWheelFrictionScales;
	CUtlVector< float32 > m_vecFractionOfWheelSubmergedForWheelDrag;
	CUtlVector< float32 > m_vecWheelDrag;
};
