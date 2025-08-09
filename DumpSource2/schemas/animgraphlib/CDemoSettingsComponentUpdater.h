// MGetKV3ClassDefaults = {
//	"_class": "CDemoSettingsComponentUpdater",
//	"m_name": "",
//	"m_id":
//	{
//		"m_id": 4294967295
//	},
//	"m_networkMode": "ServerAuthoritative",
//	"m_bStartEnabled": false,
//	"m_settings":
//	{
//		"m_vecErrorRangeSplineRotation":
//		[
//			0.100000,
//			0.500000
//		],
//		"m_vecErrorRangeSplineTranslation":
//		[
//			0.100000,
//			0.500000
//		],
//		"m_vecErrorRangeSplineScale":
//		[
//			0.100000,
//			0.500000
//		],
//		"m_flIkRotation_MaxSplineError": 0.030000,
//		"m_flIkTranslation_MaxSplineError": 0.300000,
//		"m_vecErrorRangeQuantizationRotation":
//		[
//			0.100000,
//			0.500000
//		],
//		"m_vecErrorRangeQuantizationTranslation":
//		[
//			0.100000,
//			0.500000
//		],
//		"m_vecErrorRangeQuantizationScale":
//		[
//			0.100000,
//			0.500000
//		],
//		"m_flIkRotation_MaxQuantizationError": 0.010000,
//		"m_flIkTranslation_MaxQuantizationError": 0.100000,
//		"m_baseSequence": "",
//		"m_nBaseSequenceFrame": 0,
//		"m_boneSelectionMode": "CaptureSelectedBones",
//		"m_bones":
//		[
//		],
//		"m_ikChains":
//		[
//		]
//	}
//}
class CDemoSettingsComponentUpdater : public CAnimComponentUpdater
{
	CAnimDemoCaptureSettings m_settings;
};
