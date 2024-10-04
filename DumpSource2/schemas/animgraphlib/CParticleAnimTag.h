class CParticleAnimTag : public CAnimTagBase
{
	CStrongHandle< InfoForResourceTypeIParticleSystemDefinition > m_hParticleSystem;
	CUtlString m_particleSystemName;
	CUtlString m_configName;
	bool m_bDetachFromOwner;
	bool m_bStopWhenTagEnds;
	bool m_bTagEndStopIsInstant;
	CUtlString m_attachmentName;
	ParticleAttachment_t m_attachmentType;
	CUtlString m_attachmentCP1Name;
	ParticleAttachment_t m_attachmentCP1Type;
}
