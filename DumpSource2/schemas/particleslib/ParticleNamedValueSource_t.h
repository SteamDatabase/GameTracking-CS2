class ParticleNamedValueSource_t
{
	CUtlString m_Name;
	bool m_IsPublic;
	PulseValueType_t m_ValueType;
	ParticleNamedValueConfiguration_t m_DefaultConfig;
	CUtlVector< ParticleNamedValueConfiguration_t > m_NamedConfigs;
};
