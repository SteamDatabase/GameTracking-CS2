// MGetKV3ClassDefaults = {
//	"m_vecErrorRangeSplineRotation":
//	[
//		0.100000,
//		0.500000
//	],
//	"m_vecErrorRangeSplineTranslation":
//	[
//		0.100000,
//		0.500000
//	],
//	"m_vecErrorRangeSplineScale":
//	[
//		0.100000,
//		0.500000
//	],
//	"m_flIkRotation_MaxSplineError": 0.030000,
//	"m_flIkTranslation_MaxSplineError": 0.300000,
//	"m_vecErrorRangeQuantizationRotation":
//	[
//		0.100000,
//		0.500000
//	],
//	"m_vecErrorRangeQuantizationTranslation":
//	[
//		0.100000,
//		0.500000
//	],
//	"m_vecErrorRangeQuantizationScale":
//	[
//		0.100000,
//		0.500000
//	],
//	"m_flIkRotation_MaxQuantizationError": 0.010000,
//	"m_flIkTranslation_MaxQuantizationError": 0.100000,
//	"m_baseSequence": "",
//	"m_nBaseSequenceFrame": 0,
//	"m_boneSelectionMode": "CaptureSelectedBones",
//	"m_bones":
//	[
//	],
//	"m_ikChains":
//	[
//	]
//}
class CAnimDemoCaptureSettings
{
	// MPropertyFriendlyName = "Rotation Error Range"
	// MPropertyGroupName = "+Spline Settings"
	Vector2D m_vecErrorRangeSplineRotation;
	// MPropertyFriendlyName = "Translation Error Range"
	// MPropertyGroupName = "+Spline Settings"
	Vector2D m_vecErrorRangeSplineTranslation;
	// MPropertyFriendlyName = "Scale Error Range"
	// MPropertyGroupName = "+Spline Settings"
	Vector2D m_vecErrorRangeSplineScale;
	// MPropertyFriendlyName = "Max IK Rotation Error"
	// MPropertyGroupName = "+Spline Settings"
	float32 m_flIkRotation_MaxSplineError;
	// MPropertyFriendlyName = "Max IK Translation Error"
	// MPropertyGroupName = "+Spline Settings"
	float32 m_flIkTranslation_MaxSplineError;
	// MPropertyFriendlyName = "Rotation Error Range"
	// MPropertyGroupName = "+Quantization Settings"
	Vector2D m_vecErrorRangeQuantizationRotation;
	// MPropertyFriendlyName = "Translation Error Range"
	// MPropertyGroupName = "+Quantization Settings"
	Vector2D m_vecErrorRangeQuantizationTranslation;
	// MPropertyFriendlyName = "Scale Error Range"
	// MPropertyGroupName = "+Quantization Settings"
	Vector2D m_vecErrorRangeQuantizationScale;
	// MPropertyFriendlyName = "Max IK Rotation Error"
	// MPropertyGroupName = "+Quantization Settings"
	float32 m_flIkRotation_MaxQuantizationError;
	// MPropertyFriendlyName = "Max IK Translation Error"
	// MPropertyGroupName = "+Quantization Settings"
	float32 m_flIkTranslation_MaxQuantizationError;
	// MPropertyFriendlyName = "Base Sequence"
	// MPropertyGroupName = "+Base Pose"
	// MPropertyAttributeChoiceName = "Sequence"
	CUtlString m_baseSequence;
	// MPropertyFriendlyName = "Base Sequence Frame"
	// MPropertyGroupName = "+Base Pose"
	int32 m_nBaseSequenceFrame;
	// MPropertyFriendlyName = "Bone Selection Mode"
	// MPropertyGroupName = "+Bones"
	// MPropertyAutoRebuildOnChange
	EDemoBoneSelectionMode m_boneSelectionMode;
	// MPropertyFriendlyName = "Bones"
	// MPropertyGroupName = "+Bones"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlVector< BoneDemoCaptureSettings_t > m_bones;
	// MPropertyFriendlyName = "IK Chains"
	CUtlVector< IKDemoCaptureSettings_t > m_ikChains;
};
