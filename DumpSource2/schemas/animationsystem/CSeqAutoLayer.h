// MGetKV3ClassDefaults = {
//	"m_nLocalReference": 0,
//	"m_nLocalPose": 0,
//	"m_flags":
//	{
//		"m_bPost": false,
//		"m_bSpline": false,
//		"m_bXFade": false,
//		"m_bNoBlend": false,
//		"m_bLocal": false,
//		"m_bPose": false,
//		"m_bFetchFrame": false,
//		"m_bSubtract": false
//	},
//	"m_start": 0.000000,
//	"m_peak": 0.000000,
//	"m_tail": 0.000000,
//	"m_end": 0.000000
//}
class CSeqAutoLayer
{
	int16 m_nLocalReference;
	int16 m_nLocalPose;
	CSeqAutoLayerFlag m_flags;
	float32 m_start;
	float32 m_peak;
	float32 m_tail;
	float32 m_end;
};
