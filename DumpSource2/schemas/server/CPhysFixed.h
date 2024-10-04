class CPhysFixed : public CPhysConstraint
{
	float32 m_flLinearFrequency;
	float32 m_flLinearDampingRatio;
	float32 m_flAngularFrequency;
	float32 m_flAngularDampingRatio;
	bool m_bEnableLinearConstraint;
	bool m_bEnableAngularConstraint;
}
