// MNetworkIncludeByUserGroup = "Origin"
// MNetworkIncludeByName = "m_nModelIndex"
// MNetworkIncludeByName = "m_nRenderFX"
// MNetworkIncludeByName = "m_nRenderMode"
// MNetworkIncludeByName = "m_clrRender"
// MNetworkIncludeByName = "CGameSceneNode::m_hParent"
// MNetworkOverride = "m_clrRender"
// MNetworkVarNames = "float32 m_flFrameRate"
// MNetworkVarNames = "float32 m_flHDRColorScale"
// MNetworkVarNames = "uint8 m_nNumBeamEnts"
// MNetworkVarNames = "HMaterialStrong m_hBaseMaterial"
// MNetworkVarNames = "HMaterialStrong m_nHaloIndex"
// MNetworkVarNames = "BeamType_t m_nBeamType"
// MNetworkVarNames = "uint32 m_nBeamFlags"
// MNetworkVarNames = "CHandle< CBaseEntity > m_hAttachEntity"
// MNetworkVarNames = "AttachmentHandle_t m_nAttachIndex"
// MNetworkVarNames = "float32 m_fWidth"
// MNetworkVarNames = "float32 m_fEndWidth"
// MNetworkVarNames = "float32 m_fFadeLength"
// MNetworkVarNames = "float32 m_fHaloScale"
// MNetworkVarNames = "float32 m_fAmplitude"
// MNetworkVarNames = "float32 m_fStartFrame"
// MNetworkVarNames = "float32 m_fSpeed"
// MNetworkVarNames = "float32 m_flFrame"
// MNetworkVarNames = "BeamClipStyle_t m_nClipStyle"
// MNetworkVarNames = "bool m_bTurnedOff"
// MNetworkVarNames = "VectorWS m_vecEndPos"
class C_Beam : public C_BaseModelEntity
{
	// MNetworkEnable
	// MNetworkBitCount = 10
	// MNetworkMinValue = -25.000000
	// MNetworkMaxValue = 25.000000
	// MNetworkEncodeFlags = 2
	float32 m_flFrameRate;
	// MNetworkEnable
	float32 m_flHDRColorScale;
	GameTime_t m_flFireTime;
	float32 m_flDamage;
	// MNetworkEnable
	uint8 m_nNumBeamEnts;
	// MNotSaved
	int32 m_queryHandleHalo;
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_hBaseMaterial;
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_nHaloIndex;
	// MNetworkEnable
	BeamType_t m_nBeamType;
	// MNetworkEnable
	uint32 m_nBeamFlags;
	// MNetworkEnable
	CHandle< C_BaseEntity >[10] m_hAttachEntity;
	// MNetworkEnable
	AttachmentHandle_t[10] m_nAttachIndex;
	// MNetworkEnable
	// MNetworkBitCount = 10
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 102.300003
	// MNetworkEncodeFlags = 2
	float32 m_fWidth;
	// MNetworkEnable
	// MNetworkBitCount = 10
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 102.300003
	// MNetworkEncodeFlags = 2
	float32 m_fEndWidth;
	// MNetworkEnable
	float32 m_fFadeLength;
	// MNetworkEnable
	float32 m_fHaloScale;
	// MNetworkEnable
	// MNetworkBitCount = 8
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 64.000000
	// MNetworkEncodeFlags = 1
	float32 m_fAmplitude;
	// MNetworkEnable
	// MNetworkBitCount = 8
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 256.000000
	// MNetworkEncodeFlags = 1
	float32 m_fStartFrame;
	// MNetworkEnable
	// MNetworkBitCount = 8
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 100.000000
	float32 m_fSpeed;
	// MNetworkEnable
	// MNetworkBitCount = 20
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 256.000000
	// MNetworkEncodeFlags = 1
	// MNetworkPriority = 32
	float32 m_flFrame;
	// MNetworkEnable
	BeamClipStyle_t m_nClipStyle;
	// MNetworkEnable
	bool m_bTurnedOff;
	// MNetworkEnable
	// MNetworkEncoder = "coord"
	VectorWS m_vecEndPos;
	CHandle< C_BaseEntity > m_hEndEntity;
};
