// MGetKV3ClassDefaults = {
//	"_class": "CSlopeComponentUpdater",
//	"m_name": "",
//	"m_id":
//	{
//		"m_id": 4294967295
//	},
//	"m_networkMode": "ServerAuthoritative",
//	"m_bStartEnabled": false,
//	"m_flTraceDistance": 36.000000,
//	"m_hSlopeAngle":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hSlopeAngleFront":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hSlopeAngleSide":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hSlopeHeading":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hSlopeNormal":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hSlopeNormal_WorldSpace":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	}
//}
class CSlopeComponentUpdater : public CAnimComponentUpdater
{
	float32 m_flTraceDistance;
	CAnimParamHandle m_hSlopeAngle;
	CAnimParamHandle m_hSlopeAngleFront;
	CAnimParamHandle m_hSlopeAngleSide;
	CAnimParamHandle m_hSlopeHeading;
	CAnimParamHandle m_hSlopeNormal;
	CAnimParamHandle m_hSlopeNormal_WorldSpace;
};
