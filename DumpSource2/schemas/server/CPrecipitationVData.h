class CPrecipitationVData : public CEntitySubclassVDataBase
{
	CResourceNameTyped< CWeakHandle< InfoForResourceTypeIParticleSystemDefinition > > m_szParticlePrecipitationEffect;
	float32 m_flInnerDistance;
	ParticleAttachment_t m_nAttachType;
	bool m_bBatchSameVolumeType;
	int32 m_nRTEnvCP;
	int32 m_nRTEnvCPComponent;
	CUtlString m_szModifier;
}
