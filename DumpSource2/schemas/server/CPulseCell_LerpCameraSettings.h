// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_LerpCameraSettings",
//	"m_nEditorNodeID": -1,
//	"m_WakeResume":
//	{
//		"m_SourceOutflowName": "",
//		"m_nDestChunk": -1,
//		"m_nInstruction": -1
//	},
//	"m_flSeconds": 4.000000,
//	"m_Start":
//	{
//		"m_flNearBlurryDistance": -1.000000,
//		"m_flNearCrispDistance": -1.000000,
//		"m_flFarCrispDistance": -1.000000,
//		"m_flFarBlurryDistance": -1.000000
//	},
//	"m_End":
//	{
//		"m_flNearBlurryDistance": -1.000000,
//		"m_flNearCrispDistance": -1.000000,
//		"m_flFarCrispDistance": -1.000000,
//		"m_flFarBlurryDistance": -1.000000
//	}
//}
// MCellForDomain = "BaseDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
class CPulseCell_LerpCameraSettings : public CPulseCell_BaseLerp
{
	float32 m_flSeconds;
	PointCameraSettings_t m_Start;
	PointCameraSettings_t m_End;
};
