// MGetKV3ClassDefaults = {
//	"m_blendMode": "BLOOM_BLEND_ADD",
//	"m_flBloomStrength": 2.000000,
//	"m_flScreenBloomStrength": 1.000000,
//	"m_flBlurBloomStrength": 1.000000,
//	"m_flBloomThreshold": 0.000000,
//	"m_flBloomThresholdWidth": 1.000000,
//	"m_flSkyboxBloomStrength": 1.000000,
//	"m_flBloomStartValue": 1.000000,
//	"m_flComputeBloomStrength": 0.030000,
//	"m_flComputeBloomThreshold": 1.000000,
//	"m_flComputeBloomRadius": 0.600000,
//	"m_flComputeBloomEffectsScale": 1.000000,
//	"m_flComputeBloomLensDirtStrength": 0.000000,
//	"m_flComputeBloomLensDirtBlackLevel": 0.100000,
//	"m_flBlurWeight":
//	[
//		0.200000,
//		0.200000,
//		0.200000,
//		0.200000,
//		0.200000
//	],
//	"m_vBlurTint":
//	[
//		[
//			1.000000,
//			1.000000,
//			1.000000
//		],
//		[
//			1.000000,
//			1.000000,
//			1.000000
//		],
//		[
//			1.000000,
//			1.000000,
//			1.000000
//		],
//		[
//			1.000000,
//			1.000000,
//			1.000000
//		],
//		[
//			1.000000,
//			1.000000,
//			1.000000
//		]
//	]
//}
class PostProcessingBloomParameters_t
{
	BloomBlendMode_t m_blendMode;
	float32 m_flBloomStrength;
	float32 m_flScreenBloomStrength;
	float32 m_flBlurBloomStrength;
	float32 m_flBloomThreshold;
	float32 m_flBloomThresholdWidth;
	float32 m_flSkyboxBloomStrength;
	float32 m_flBloomStartValue;
	float32 m_flComputeBloomStrength;
	float32 m_flComputeBloomThreshold;
	float32 m_flComputeBloomRadius;
	float32 m_flComputeBloomEffectsScale;
	float32 m_flComputeBloomLensDirtStrength;
	float32 m_flComputeBloomLensDirtBlackLevel;
	float32[5] m_flBlurWeight;
	Vector[5] m_vBlurTint;
};
