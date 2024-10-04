class CRopeKeyframe : public CBaseModelEntity
{
	uint16 m_RopeFlags;
	CUtlSymbolLarge m_iNextLinkName;
	int16 m_Slack;
	float32 m_Width;
	float32 m_TextureScale;
	uint8 m_nSegments;
	bool m_bConstrainBetweenEndpoints;
	CUtlSymbolLarge m_strRopeMaterialModel;
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_iRopeMaterialModelIndex;
	uint8 m_Subdiv;
	uint8 m_nChangeCount;
	int16 m_RopeLength;
	uint8 m_fLockedPoints;
	bool m_bCreatedFromMapFile;
	float32 m_flScrollSpeed;
	bool m_bStartPointValid;
	bool m_bEndPointValid;
	CHandle< CBaseEntity > m_hStartPoint;
	CHandle< CBaseEntity > m_hEndPoint;
	AttachmentHandle_t m_iStartAttachment;
	AttachmentHandle_t m_iEndAttachment;
};
