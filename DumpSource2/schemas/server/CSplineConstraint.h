class CSplineConstraint : public CPhysConstraint
{
	Vector m_vAnchorOffsetRestore;
	CHandle< CBaseEntity > m_hSplineEntity;
	bool m_bEnableLateralConstraint;
	bool m_bEnableVerticalConstraint;
	bool m_bEnableAngularConstraint;
	bool m_bEnableLimit;
	bool m_bFireEventsOnPath;
	float32 m_flLinearFrequency;
	float32 m_flLinarDampingRatio;
	float32 m_flJointFriction;
	Vector m_vPreSolveAnchorPos;
};
