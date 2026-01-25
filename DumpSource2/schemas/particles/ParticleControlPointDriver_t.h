// MGetKV3ClassDefaults = {
//	"m_iControlPoint": 0,
//	"m_iAttachType": "PATTACH_ABSORIGIN_FOLLOW",
//	"m_attachmentName": "",
//	"m_vecOffset":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_angOffset":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_entityName": ""
//}
class ParticleControlPointDriver_t
{
	ParticleParamID_t m_iControlPoint;
	ParticleAttachment_t m_iAttachType;
	CUtlString m_attachmentName;
	Vector m_vecOffset;
	QAngle m_angOffset;
	CUtlString m_entityName;
};
