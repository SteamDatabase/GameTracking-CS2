// MNetworkVarNames = "Vector m_vOrigin"
// MNetworkVarNames = "Vector m_vStart"
// MNetworkVarNames = "Vector m_vNormal"
// MNetworkVarNames = "QAngle m_vAngles"
// MNetworkVarNames = "CEntityHandle m_hEntity"
// MNetworkVarNames = "CEntityHandle m_hOtherEntity"
// MNetworkVarNames = "float32 m_flScale"
// MNetworkVarNames = "float32 m_flMagnitude"
// MNetworkVarNames = "float32 m_flRadius"
// MNetworkVarNames = "CUtlStringToken m_nSurfaceProp"
// MNetworkVarNames = "HParticleSystemDefinition m_nEffectIndex"
// MNetworkVarNames = "uint32 m_nDamageType"
// MNetworkVarNames = "uint8 m_nPenetrate"
// MNetworkVarNames = "uint16 m_nMaterial"
// MNetworkVarNames = "int16 m_nHitBox"
// MNetworkVarNames = "uint8 m_nColor"
// MNetworkVarNames = "uint8 m_fFlags"
// MNetworkVarNames = "AttachmentHandle_t m_nAttachmentIndex"
// MNetworkVarNames = "CUtlStringToken m_nAttachmentName"
// MNetworkVarNames = "uint16 m_iEffectName"
// MNetworkVarNames = "uint8 m_nExplosionType"
class CEffectData
{
	// MNetworkEnable
	// MNetworkEncoder = "coord_integral"
	Vector m_vOrigin;
	// MNetworkEnable
	// MNetworkEncoder = "coord_integral"
	Vector m_vStart;
	// MNetworkEnable
	// MNetworkEncoder = "normal"
	Vector m_vNormal;
	// MNetworkEnable
	// MNetworkEncoder = "qangle"
	QAngle m_vAngles;
	// MNetworkEnable
	CEntityHandle m_hEntity;
	// MNetworkEnable
	CEntityHandle m_hOtherEntity;
	// MNetworkEnable
	float32 m_flScale;
	// MNetworkEnable
	// MNetworkBitCount = 12
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 1023.000000
	// MNetworkEncodeFlags = 1
	float32 m_flMagnitude;
	// MNetworkEnable
	// MNetworkBitCount = 10
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 1023.000000
	// MNetworkEncodeFlags = 1
	float32 m_flRadius;
	// MNetworkEnable
	CUtlStringToken m_nSurfaceProp;
	// MNetworkEnable
	CWeakHandle< InfoForResourceTypeIParticleSystemDefinition > m_nEffectIndex;
	// MNetworkEnable
	uint32 m_nDamageType;
	// MNetworkEnable
	uint8 m_nPenetrate;
	// MNetworkEnable
	uint16 m_nMaterial;
	// MNetworkEnable
	int16 m_nHitBox;
	// MNetworkEnable
	uint8 m_nColor;
	// MNetworkEnable
	uint8 m_fFlags;
	// MNetworkEnable
	AttachmentHandle_t m_nAttachmentIndex;
	// MNetworkEnable
	CUtlStringToken m_nAttachmentName;
	// MNetworkEnable
	uint16 m_iEffectName;
	// MNetworkEnable
	uint8 m_nExplosionType;
};
