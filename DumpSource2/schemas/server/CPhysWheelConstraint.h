class CPhysWheelConstraint : public CPhysConstraint
{
	float32 m_flSuspensionFrequency;
	float32 m_flSuspensionDampingRatio;
	float32 m_flSuspensionHeightOffset;
	bool m_bEnableSuspensionLimit;
	float32 m_flMinSuspensionOffset;
	float32 m_flMaxSuspensionOffset;
	bool m_bEnableSteeringLimit;
	float32 m_flMinSteeringAngle;
	float32 m_flMaxSteeringAngle;
	float32 m_flSteeringAxisFriction;
	float32 m_flSpinAxisFriction;
};
