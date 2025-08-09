// MGetKV3ClassDefaults = {
//	"m_sDebugName": "",
//	"m_vPosition":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_qOrientation":
//	[
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000
//	],
//	"m_vLinearVelocity":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_vAngularVelocity":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_vLocalMassCenter":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_LocalInertiaInv":
//	[
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		]
//	],
//	"m_flMassInv": 0.000000,
//	"m_flGameMass": 0.000000,
//	"m_flMassScaleInv": 1.000000,
//	"m_flInertiaScaleInv": 1.000000,
//	"m_flLinearDamping": 0.000000,
//	"m_flAngularDamping": 0.000000,
//	"m_flLinearDrag": 1.000000,
//	"m_flAngularDrag": 1.000000,
//	"m_flLinearBuoyancyDrag": 1.000000,
//	"m_flAngularBuoyancyDrag": 1.000000,
//	"m_vLastAwakeForceAccum":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_vLastAwakeTorqueAccum":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_flBuoyancyFactor": 1.000000,
//	"m_flGravityScale": 1.000000,
//	"m_flTimeScale": 1.000000,
//	"m_nBodyType": 0,
//	"m_nGameIndex": 0,
//	"m_nGameFlags": 0,
//	"m_nMinVelocityIterations": 1,
//	"m_nMinPositionIterations": 0,
//	"m_nMassPriority": 0,
//	"m_bEnabled": true,
//	"m_bSleeping": false,
//	"m_bIsContinuousEnabled": true,
//	"m_bDragEnabled": true,
//	"m_bBuoyancyDragEnabled": true,
//	"m_vGravity":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_bSpeculativeEnabled": true,
//	"m_bHasShadowController": false,
//	"m_nDynamicContinuousContactBehavior": "DYNAMIC_CONTINUOUS_ALLOW_IF_REQUESTED_BY_OTHER_BODY"
//}
class RnBodyDesc_t
{
	CUtlString m_sDebugName;
	Vector m_vPosition;
	QuaternionStorage m_qOrientation;
	Vector m_vLinearVelocity;
	Vector m_vAngularVelocity;
	Vector m_vLocalMassCenter;
	Vector[3] m_LocalInertiaInv;
	float32 m_flMassInv;
	float32 m_flGameMass;
	float32 m_flMassScaleInv;
	float32 m_flInertiaScaleInv;
	float32 m_flLinearDamping;
	float32 m_flAngularDamping;
	float32 m_flLinearDrag;
	float32 m_flAngularDrag;
	float32 m_flLinearBuoyancyDrag;
	float32 m_flAngularBuoyancyDrag;
	Vector m_vLastAwakeForceAccum;
	Vector m_vLastAwakeTorqueAccum;
	float32 m_flBuoyancyFactor;
	float32 m_flGravityScale;
	float32 m_flTimeScale;
	int32 m_nBodyType;
	uint32 m_nGameIndex;
	uint32 m_nGameFlags;
	int8 m_nMinVelocityIterations;
	int8 m_nMinPositionIterations;
	int8 m_nMassPriority;
	bool m_bEnabled;
	bool m_bSleeping;
	bool m_bIsContinuousEnabled;
	bool m_bDragEnabled;
	bool m_bBuoyancyDragEnabled;
	Vector m_vGravity;
	bool m_bSpeculativeEnabled;
	bool m_bHasShadowController;
	DynamicContinuousContactBehavior_t m_nDynamicContinuousContactBehavior;
};
