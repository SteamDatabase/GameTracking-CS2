// MNetworkIncludeByUserGroup = "Origin"
// MNetworkIncludeByName = "CGameSceneNode::m_hParent"
// MNetworkIncludeByName = "CGameSceneNode::m_hierarchyAttachName"
// MNetworkIncludeByName = "m_nMinCPULevel"
// MNetworkIncludeByName = "m_nMaxCPULevel"
// MNetworkIncludeByName = "m_nMinGPULevel"
// MNetworkIncludeByName = "m_nMaxGPULevel"
// MNetworkVarNames = "uint16 m_RopeFlags"
// MNetworkVarNames = "int16 m_Slack"
// MNetworkVarNames = "float32 m_Width"
// MNetworkVarNames = "float32 m_TextureScale"
// MNetworkVarNames = "uint8 m_nSegments"
// MNetworkVarNames = "bool m_bConstrainBetweenEndpoints"
// MNetworkVarNames = "HMaterialStrong m_iRopeMaterialModelIndex"
// MNetworkVarNames = "uint8 m_Subdiv"
// MNetworkVarNames = "uint8 m_nChangeCount"
// MNetworkVarNames = "int16 m_RopeLength"
// MNetworkVarNames = "uint8 m_fLockedPoints"
// MNetworkVarNames = "float32 m_flScrollSpeed"
// MNetworkVarNames = "CHandle< CBaseEntity> m_hStartPoint"
// MNetworkVarNames = "CHandle< CBaseEntity> m_hEndPoint"
// MNetworkVarNames = "AttachmentHandle_t m_iStartAttachment"
// MNetworkVarNames = "AttachmentHandle_t m_iEndAttachment"
class CRopeKeyframe : public CBaseModelEntity
{
	// MNetworkEnable
	uint16 m_RopeFlags;
	CUtlSymbolLarge m_iNextLinkName;
	// MNetworkEnable
	int16 m_Slack;
	// MNetworkEnable
	float32 m_Width;
	// MNetworkEnable
	// MNetworkBitCount = 10
	// MNetworkMinValue = 0.100000
	// MNetworkMaxValue = 10.000000
	float32 m_TextureScale;
	// MNetworkEnable
	uint8 m_nSegments;
	// MNetworkEnable
	bool m_bConstrainBetweenEndpoints;
	CUtlSymbolLarge m_strRopeMaterialModel;
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_iRopeMaterialModelIndex;
	// MNetworkEnable
	uint8 m_Subdiv;
	// MNetworkEnable
	// MNotSaved
	uint8 m_nChangeCount;
	// MNetworkEnable
	int16 m_RopeLength;
	// MNetworkEnable
	uint8 m_fLockedPoints;
	bool m_bCreatedFromMapFile;
	// MNetworkEnable
	float32 m_flScrollSpeed;
	bool m_bStartPointValid;
	bool m_bEndPointValid;
	// MNetworkEnable
	CHandle< CBaseEntity > m_hStartPoint;
	// MNetworkEnable
	CHandle< CBaseEntity > m_hEndPoint;
	// MNetworkEnable
	AttachmentHandle_t m_iStartAttachment;
	// MNetworkEnable
	AttachmentHandle_t m_iEndAttachment;
};
