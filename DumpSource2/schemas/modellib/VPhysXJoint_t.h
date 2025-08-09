// MGetKV3ClassDefaults = {
//	"m_nType": 0,
//	"m_nBody1": 0,
//	"m_nBody2": 0,
//	"m_nFlags": 0,
//	"m_Frame1":
//	[
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000
//	],
//	"m_Frame2":
//	[
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000
//	],
//	"m_bEnableCollision": false,
//	"m_bIsLinearConstraintDisabled": false,
//	"m_bIsAngularConstraintDisabled": false,
//	"m_bEnableLinearLimit": false,
//	"m_LinearLimit":
//	{
//		"m_flMin": 0.000000,
//		"m_flMax": 0.000000
//	},
//	"m_bEnableLinearMotor": false,
//	"m_vLinearTargetVelocity":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_flMaxForce": 0.000000,
//	"m_bEnableSwingLimit": false,
//	"m_SwingLimit":
//	{
//		"m_flMin": 0.000000,
//		"m_flMax": 0.000000
//	},
//	"m_bEnableTwistLimit": false,
//	"m_TwistLimit":
//	{
//		"m_flMin": 0.000000,
//		"m_flMax": 0.000000
//	},
//	"m_bEnableAngularMotor": false,
//	"m_vAngularTargetVelocity":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_flMaxTorque": 0.000000,
//	"m_flLinearFrequency": 0.000000,
//	"m_flLinearDampingRatio": 0.000000,
//	"m_flAngularFrequency": 0.000000,
//	"m_flAngularDampingRatio": 0.000000,
//	"m_flFriction": 0.000000,
//	"m_flElasticity": 0.000000,
//	"m_flElasticDamping": 0.000000,
//	"m_flPlasticity": 0.000000,
//	"m_Tag": ""
//}
class VPhysXJoint_t
{
	uint16 m_nType;
	uint16 m_nBody1;
	uint16 m_nBody2;
	uint16 m_nFlags;
	CTransform m_Frame1;
	CTransform m_Frame2;
	bool m_bEnableCollision;
	bool m_bIsLinearConstraintDisabled;
	bool m_bIsAngularConstraintDisabled;
	bool m_bEnableLinearLimit;
	VPhysXRange_t m_LinearLimit;
	bool m_bEnableLinearMotor;
	Vector m_vLinearTargetVelocity;
	float32 m_flMaxForce;
	bool m_bEnableSwingLimit;
	VPhysXRange_t m_SwingLimit;
	bool m_bEnableTwistLimit;
	VPhysXRange_t m_TwistLimit;
	bool m_bEnableAngularMotor;
	Vector m_vAngularTargetVelocity;
	float32 m_flMaxTorque;
	float32 m_flLinearFrequency;
	float32 m_flLinearDampingRatio;
	float32 m_flAngularFrequency;
	float32 m_flAngularDampingRatio;
	float32 m_flFriction;
	float32 m_flElasticity;
	float32 m_flElasticDamping;
	float32 m_flPlasticity;
	CUtlString m_Tag;
};
