class CEffectData
{
	Vector m_vOrigin;
	Vector m_vStart;
	Vector m_vNormal;
	QAngle m_vAngles;
	CEntityHandle m_hEntity;
	CEntityHandle m_hOtherEntity;
	float32 m_flScale;
	float32 m_flMagnitude;
	float32 m_flRadius;
	CUtlStringToken m_nSurfaceProp;
	CWeakHandle< InfoForResourceTypeIParticleSystemDefinition > m_nEffectIndex;
	uint32 m_nDamageType;
	uint8 m_nPenetrate;
	uint16 m_nMaterial;
	uint16 m_nHitBox;
	uint8 m_nColor;
	uint8 m_fFlags;
	AttachmentHandle_t m_nAttachmentIndex;
	CUtlStringToken m_nAttachmentName;
	uint16 m_iEffectName;
	uint8 m_nExplosionType;
}
