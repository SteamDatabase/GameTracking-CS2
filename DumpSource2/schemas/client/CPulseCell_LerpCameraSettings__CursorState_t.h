// MGetKV3ClassDefaults = {
//	"m_StartTime": null,
//	"m_EndTime": null,
//	"m_hCamera": null,
//	"m_OverlaidStart":
//	{
//		"m_flNearBlurryDistance": -1.000000,
//		"m_flNearCrispDistance": -1.000000,
//		"m_flFarCrispDistance": -1.000000,
//		"m_flFarBlurryDistance": -1.000000
//	},
//	"m_OverlaidEnd":
//	{
//		"m_flNearBlurryDistance": -1.000000,
//		"m_flNearCrispDistance": -1.000000,
//		"m_flFarCrispDistance": -1.000000,
//		"m_flFarBlurryDistance": -1.000000
//	}
//}
class CPulseCell_LerpCameraSettings::CursorState_t : public CPulseCell_BaseLerp::CursorState_t
{
	CHandle< C_PointCamera > m_hCamera;
	PointCameraSettings_t m_OverlaidStart;
	PointCameraSettings_t m_OverlaidEnd;
};
