// MGetKV3ClassDefaults = {
//	"m_bHasTonemapParams": false,
//	"m_toneMapParams":
//	{
//		"m_flExposureBias": 0.000000,
//		"m_flShoulderStrength": 0.000000,
//		"m_flLinearStrength": 0.000000,
//		"m_flLinearAngle": 0.000000,
//		"m_flToeStrength": 0.000000,
//		"m_flToeNum": 0.000000,
//		"m_flToeDenom": 0.000000,
//		"m_flWhitePoint": 0.000000,
//		"m_flLuminanceSource": 0.000000,
//		"m_flExposureBiasShadows": 0.000000,
//		"m_flExposureBiasHighlights": 0.000000,
//		"m_flMinShadowLum": 0.000000,
//		"m_flMaxShadowLum": 0.000000,
//		"m_flMinHighlightLum": 0.000000,
//		"m_flMaxHighlightLum": 0.000000
//	},
//	"m_bHasBloomParams": false,
//	"m_bloomParams":
//	{
//		"m_blendMode": "BLOOM_BLEND_ADD",
//		"m_flBloomStrength": 2.000000,
//		"m_flScreenBloomStrength": 1.000000,
//		"m_flBlurBloomStrength": 1.000000,
//		"m_flBloomThreshold": 0.000000,
//		"m_flBloomThresholdWidth": 1.000000,
//		"m_flSkyboxBloomStrength": 1.000000,
//		"m_flBloomStartValue": 1.000000,
//		"m_flComputeBloomStrength": 0.030000,
//		"m_flComputeBloomThreshold": 1.000000,
//		"m_flComputeBloomRadius": 0.600000,
//		"m_flComputeBloomEffectsScale": 1.000000,
//		"m_flComputeBloomLensDirtStrength": 0.000000,
//		"m_flComputeBloomLensDirtBlackLevel": 0.100000,
//		"m_flBlurWeight":
//		[
//			0.200000,
//			0.200000,
//			0.200000,
//			0.200000,
//			0.200000
//		],
//		"m_vBlurTint":
//		[
//			[
//				1.000000,
//				1.000000,
//				1.000000
//			],
//			[
//				1.000000,
//				1.000000,
//				1.000000
//			],
//			[
//				1.000000,
//				1.000000,
//				1.000000
//			],
//			[
//				1.000000,
//				1.000000,
//				1.000000
//			],
//			[
//				1.000000,
//				1.000000,
//				1.000000
//			]
//		]
//	},
//	"m_bHasVignetteParams": false,
//	"m_vignetteParams":
//	{
//		"m_flVignetteStrength": 0.000000,
//		"m_vCenter":
//		[
//			0.000000,
//			0.000000
//		],
//		"m_flRadius": 0.500000,
//		"m_flRoundness": 1.000000,
//		"m_flFeather": 0.500000,
//		"m_vColorTint":
//		[
//			1.000000,
//			1.000000,
//			1.000000
//		]
//	},
//	"m_bHasLocalContrastParams": false,
//	"m_localConstrastParams":
//	{
//		"m_flLocalContrastStrength": 0.000000,
//		"m_flLocalContrastEdgeStrength": 0.000000,
//		"m_flLocalContrastVignetteStart": 0.000000,
//		"m_flLocalContrastVignetteEnd": 0.000000,
//		"m_flLocalContrastVignetteBlur": 0.000000
//	},
//	"m_nColorCorrectionVolumeDim": 0,
//	"m_colorCorrectionVolumeData": "[BINARY BLOB]",
//	"m_bHasColorCorrection": true,
//	"m_bHasFogScatteringParams": false,
//	"m_fogScatteringParams":
//	{
//		"m_fRadius": 0.750000,
//		"m_fScale": 0.000000,
//		"m_fCubemapScale": 1.000000,
//		"m_fVolumetricScale": 1.000000,
//		"m_fGradientScale": 1.000000
//	}
//}
class PostProcessingResource_t
{
	bool m_bHasTonemapParams;
	PostProcessingTonemapParameters_t m_toneMapParams;
	bool m_bHasBloomParams;
	PostProcessingBloomParameters_t m_bloomParams;
	bool m_bHasVignetteParams;
	PostProcessingVignetteParameters_t m_vignetteParams;
	bool m_bHasLocalContrastParams;
	PostProcessingLocalContrastParameters_t m_localConstrastParams;
	int32 m_nColorCorrectionVolumeDim;
	CUtlBinaryBlock m_colorCorrectionVolumeData;
	bool m_bHasColorCorrection;
	bool m_bHasFogScatteringParams;
	PostProcessingFogScatteringParameters_t m_fogScatteringParams;
};
