// MGetKV3ClassDefaults = {
//	"_class": "CVoiceContainerParameterBlender",
//	"m_vSound":
//	{
//		"m_nRate": 0,
//		"m_nFormat": "PCM16",
//		"m_nChannels": 0,
//		"m_nLoopStart": 0,
//		"m_nSampleCount": 0,
//		"m_flDuration": 0.000000,
//		"m_Sentences":
//		[
//		],
//		"m_nStreamingSize": 0,
//		"m_nSeekTable":
//		[
//		],
//		"m_nLoopEnd": 0,
//		"m_encodedHeader": "[BINARY BLOB]"
//	},
//	"m_pEnvelopeAnalyzer": null,
//	"m_firstSound":
//	{
//		"m_bUseReference": true,
//		"m_sound": "",
//		"m_pSound": null
//	},
//	"m_secondSound":
//	{
//		"m_bUseReference": true,
//		"m_sound": "",
//		"m_pSound": null
//	},
//	"m_bEnableOcclusionBlend": false,
//	"m_curve1":
//	{
//		"m_spline":
//		[
//		],
//		"m_tangents":
//		[
//		],
//		"m_vDomainMins":
//		[
//			0.000000,
//			0.000000
//		],
//		"m_vDomainMaxs":
//		[
//			0.000000,
//			0.000000
//		]
//	},
//	"m_curve2":
//	{
//		"m_spline":
//		[
//		],
//		"m_tangents":
//		[
//		],
//		"m_vDomainMins":
//		[
//			0.000000,
//			0.000000
//		],
//		"m_vDomainMaxs":
//		[
//			0.000000,
//			0.000000
//		]
//	},
//	"m_bEnableDistanceBlend": false,
//	"m_curve3":
//	{
//		"m_spline":
//		[
//		],
//		"m_tangents":
//		[
//		],
//		"m_vDomainMins":
//		[
//			0.000000,
//			0.000000
//		],
//		"m_vDomainMaxs":
//		[
//			0.000000,
//			0.000000
//		]
//	},
//	"m_curve4":
//	{
//		"m_spline":
//		[
//		],
//		"m_tangents":
//		[
//		],
//		"m_vDomainMins":
//		[
//			0.000000,
//			0.000000
//		],
//		"m_vDomainMaxs":
//		[
//			0.000000,
//			0.000000
//		]
//	}
//}
// MPropertyFriendlyName = "Parameter Blender"
// MPropertyDescription = "Blends two containers according to parameter curves."
class CVoiceContainerParameterBlender : public CVoiceContainerBase
{
	// MPropertyFriendlyName = "First Sound"
	CSoundContainerReference m_firstSound;
	// MPropertyFriendlyName = "Second Sound"
	CSoundContainerReference m_secondSound;
	// MPropertyStartGroup = "Occlusion"
	// MPropertyFriendlyName = "Enable Occlusion Blend"
	bool m_bEnableOcclusionBlend;
	// MPropertySuppressExpr = "m_bEnableOcclusionBlend == false"
	// MPropertyFriendlyName = "First Curve"
	CPiecewiseCurve m_curve1;
	// MPropertySuppressExpr = "m_bEnableOcclusionBlend == false"
	// MPropertyFriendlyName = "Second Curve"
	CPiecewiseCurve m_curve2;
	// MPropertyStartGroup = "Distance"
	// MPropertyFriendlyName = "Enable Distance Blend"
	bool m_bEnableDistanceBlend;
	// MPropertySuppressExpr = "m_bEnableDistanceBlend == false"
	// MPropertyFriendlyName = "First Curve"
	CPiecewiseCurve m_curve3;
	// MPropertySuppressExpr = "m_bEnableDistanceBlend == false"
	// MPropertyFriendlyName = "Second Curve"
	CPiecewiseCurve m_curve4;
};
