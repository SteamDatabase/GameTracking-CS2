class CPhysSurfaceProperties
{
	CUtlString m_name;
	uint32 m_nameHash;
	uint32 m_baseNameHash;
	bool m_bHidden;
	CUtlString m_description;
	CPhysSurfacePropertiesPhysics m_physics;
	CPhysSurfacePropertiesSoundNames m_audioSounds;
	CPhysSurfacePropertiesAudio m_audioParams;
};
