// MGetKV3ClassDefaults = {
//	"m_nType": 0,
//	"m_nTranslateMotion": 0,
//	"m_nRotateMotion": 0,
//	"m_nFlags": 0,
//	"m_anchor":
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
//		]
//	],
//	"m_axes":
//	[
//		[
//			0.000000,
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		[
//			0.000000,
//			0.000000,
//			0.000000,
//			0.000000
//		]
//	],
//	"m_maxForce": 0.000000,
//	"m_maxTorque": 0.000000,
//	"m_linearLimitValue": 0.000000,
//	"m_linearLimitRestitution": 0.000000,
//	"m_linearLimitSpring": 0.000000,
//	"m_linearLimitDamping": 0.000000,
//	"m_twistLowLimitValue": 0.000000,
//	"m_twistLowLimitRestitution": 0.000000,
//	"m_twistLowLimitSpring": 0.000000,
//	"m_twistLowLimitDamping": 0.000000,
//	"m_twistHighLimitValue": 0.000000,
//	"m_twistHighLimitRestitution": 0.000000,
//	"m_twistHighLimitSpring": 0.000000,
//	"m_twistHighLimitDamping": 0.000000,
//	"m_swing1LimitValue": 0.000000,
//	"m_swing1LimitRestitution": 0.000000,
//	"m_swing1LimitSpring": 0.000000,
//	"m_swing1LimitDamping": 0.000000,
//	"m_swing2LimitValue": 0.000000,
//	"m_swing2LimitRestitution": 0.000000,
//	"m_swing2LimitSpring": 0.000000,
//	"m_swing2LimitDamping": 0.000000,
//	"m_goalPosition":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_goalOrientation":
//	[
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_goalAngularVelocity":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_driveSpringX": 0.000000,
//	"m_driveSpringY": 0.000000,
//	"m_driveSpringZ": 0.000000,
//	"m_driveDampingX": 0.000000,
//	"m_driveDampingY": 0.000000,
//	"m_driveDampingZ": 0.000000,
//	"m_driveSpringTwist": 0.000000,
//	"m_driveSpringSwing": 0.000000,
//	"m_driveSpringSlerp": 0.000000,
//	"m_driveDampingTwist": 0.000000,
//	"m_driveDampingSwing": 0.000000,
//	"m_driveDampingSlerp": 0.000000,
//	"m_solverIterationCount": 0,
//	"m_projectionLinearTolerance": 0.000000,
//	"m_projectionAngularTolerance": 0.000000
//}
class VPhysXConstraintParams_t
{
	int8 m_nType;
	int8 m_nTranslateMotion;
	int8 m_nRotateMotion;
	int8 m_nFlags;
	Vector[2] m_anchor;
	QuaternionStorage[2] m_axes;
	float32 m_maxForce;
	float32 m_maxTorque;
	float32 m_linearLimitValue;
	float32 m_linearLimitRestitution;
	float32 m_linearLimitSpring;
	float32 m_linearLimitDamping;
	float32 m_twistLowLimitValue;
	float32 m_twistLowLimitRestitution;
	float32 m_twistLowLimitSpring;
	float32 m_twistLowLimitDamping;
	float32 m_twistHighLimitValue;
	float32 m_twistHighLimitRestitution;
	float32 m_twistHighLimitSpring;
	float32 m_twistHighLimitDamping;
	float32 m_swing1LimitValue;
	float32 m_swing1LimitRestitution;
	float32 m_swing1LimitSpring;
	float32 m_swing1LimitDamping;
	float32 m_swing2LimitValue;
	float32 m_swing2LimitRestitution;
	float32 m_swing2LimitSpring;
	float32 m_swing2LimitDamping;
	Vector m_goalPosition;
	QuaternionStorage m_goalOrientation;
	Vector m_goalAngularVelocity;
	float32 m_driveSpringX;
	float32 m_driveSpringY;
	float32 m_driveSpringZ;
	float32 m_driveDampingX;
	float32 m_driveDampingY;
	float32 m_driveDampingZ;
	float32 m_driveSpringTwist;
	float32 m_driveSpringSwing;
	float32 m_driveSpringSlerp;
	float32 m_driveDampingTwist;
	float32 m_driveDampingSwing;
	float32 m_driveDampingSlerp;
	int32 m_solverIterationCount;
	float32 m_projectionLinearTolerance;
	float32 m_projectionAngularTolerance;
};
