// MNetworkIncludeByUserGroup = "Origin"
// MNetworkIncludeByName = "CGameSceneNode::m_hParent"
// MNetworkIncludeByName = "CGameSceneNode::m_hierarchyAttachName"
// MNetworkIncludeByName = "m_nMinCPULevel"
// MNetworkIncludeByName = "m_nMaxCPULevel"
// MNetworkIncludeByName = "m_nMinGPULevel"
// MNetworkIncludeByName = "m_nMaxGPULevel"
// MNetworkVarNames = "float32 m_flScrollSpeed"
// MNetworkVarNames = "uint16 m_RopeFlags"
// MNetworkVarNames = "HMaterialStrong m_iRopeMaterialModelIndex"
// MNetworkVarNames = "uint8 m_nSegments"
// MNetworkVarNames = "CHandle< C_BaseEntity> m_hStartPoint"
// MNetworkVarNames = "CHandle< C_BaseEntity> m_hEndPoint"
// MNetworkVarNames = "AttachmentHandle_t m_iStartAttachment"
// MNetworkVarNames = "AttachmentHandle_t m_iEndAttachment"
// MNetworkVarNames = "uint8 m_Subdiv"
// MNetworkVarNames = "int16 m_RopeLength"
// MNetworkVarNames = "int16 m_Slack"
// MNetworkVarNames = "float32 m_TextureScale"
// MNetworkVarNames = "uint8 m_fLockedPoints"
// MNetworkVarNames = "uint8 m_nChangeCount"
// MNetworkVarNames = "float32 m_Width"
// MNetworkVarNames = "bool m_bConstrainBetweenEndpoints"
class C_RopeKeyframe : public C_BaseModelEntity
{
	CBitVec< 10 > m_LinksTouchingSomething;
	int32 m_nLinksTouchingSomething;
	bool m_bApplyWind;
	int32 m_fPrevLockedPoints;
	int32 m_iForcePointMoveCounter;
	bool[2] m_bPrevEndPointPos;
	Vector[2] m_vPrevEndPointPos;
	float32 m_flCurScroll;
	// MNetworkEnable
	float32 m_flScrollSpeed;
	// MNetworkEnable
	uint16 m_RopeFlags;
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_iRopeMaterialModelIndex;
	// MNetworkEnable
	uint8 m_nSegments;
	// MNetworkEnable
	CHandle< C_BaseEntity > m_hStartPoint;
	// MNetworkEnable
	CHandle< C_BaseEntity > m_hEndPoint;
	// MNetworkEnable
	AttachmentHandle_t m_iStartAttachment;
	// MNetworkEnable
	AttachmentHandle_t m_iEndAttachment;
	// MNetworkEnable
	uint8 m_Subdiv;
	// MNetworkEnable
	// MNetworkChangeCallback = "RecomputeSprings"
	int16 m_RopeLength;
	// MNetworkEnable
	// MNetworkChangeCallback = "RecomputeSprings"
	int16 m_Slack;
	// MNetworkEnable
	// MNetworkBitCount = 10
	// MNetworkMinValue = 0.100000
	// MNetworkMaxValue = 10.000000
	float32 m_TextureScale;
	// MNetworkEnable
	uint8 m_fLockedPoints;
	// MNetworkEnable
	uint8 m_nChangeCount;
	// MNetworkEnable
	float32 m_Width;
	C_RopeKeyframe::CPhysicsDelegate m_PhysicsDelegate;
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_hMaterial;
	int32 m_TextureHeight;
	Vector m_vecImpulse;
	Vector m_vecPreviousImpulse;
	float32 m_flCurrentGustTimer;
	float32 m_flCurrentGustLifetime;
	float32 m_flTimeToNextGust;
	Vector m_vWindDir;
	Vector m_vColorMod;
	Vector[2] m_vCachedEndPointAttachmentPos;
	QAngle[2] m_vCachedEndPointAttachmentAngle;
	// MNetworkEnable
	bool m_bConstrainBetweenEndpoints;
	bitfield:1 m_bEndPointAttachmentPositionsDirty;
	bitfield:1 m_bEndPointAttachmentAnglesDirty;
	bitfield:1 m_bNewDataThisFrame;
	bitfield:1 m_bPhysicsInitted;
};
