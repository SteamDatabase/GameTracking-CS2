// MGetKV3ClassDefaults = {
//	"_class": "CPrecipitationVData",
//	"m_szParticlePrecipitationEffect": "",
//	"m_flInnerDistance": 32.000000,
//	"m_nAttachType": "PATTACH_ABSORIGIN_FOLLOW",
//	"m_bBatchSameVolumeType": true,
//	"m_nRTEnvCP": -1,
//	"m_nRTEnvCPComponent": 0,
//	"m_szModifier": ""
//}
class CPrecipitationVData : public CEntitySubclassVDataBase
{
	CResourceNameTyped< CWeakHandle< InfoForResourceTypeIParticleSystemDefinition > > m_szParticlePrecipitationEffect;
	float32 m_flInnerDistance;
	ParticleAttachment_t m_nAttachType;
	bool m_bBatchSameVolumeType;
	int32 m_nRTEnvCP;
	int32 m_nRTEnvCPComponent;
	CUtlString m_szModifier;
};
