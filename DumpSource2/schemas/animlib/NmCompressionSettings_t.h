// MGetKV3ClassDefaults = {
//	"m_translationRangeX":
//	{
//		"m_flRangeStart": 0.000000,
//		"m_flRangeLength": -1.000000
//	},
//	"m_translationRangeY":
//	{
//		"m_flRangeStart": 0.000000,
//		"m_flRangeLength": -1.000000
//	},
//	"m_translationRangeZ":
//	{
//		"m_flRangeStart": 0.000000,
//		"m_flRangeLength": -1.000000
//	},
//	"m_scaleRange":
//	{
//		"m_flRangeStart": 0.000000,
//		"m_flRangeLength": -1.000000
//	},
//	"m_constantRotation":
//	[
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_bIsRotationStatic": false,
//	"m_bIsTranslationStatic": false,
//	"m_bIsScaleStatic": false
//}
class NmCompressionSettings_t
{
	NmCompressionSettings_t::QuantizationRange_t m_translationRangeX;
	NmCompressionSettings_t::QuantizationRange_t m_translationRangeY;
	NmCompressionSettings_t::QuantizationRange_t m_translationRangeZ;
	NmCompressionSettings_t::QuantizationRange_t m_scaleRange;
	Quaternion m_constantRotation;
	bool m_bIsRotationStatic;
	bool m_bIsTranslationStatic;
	bool m_bIsScaleStatic;
};
