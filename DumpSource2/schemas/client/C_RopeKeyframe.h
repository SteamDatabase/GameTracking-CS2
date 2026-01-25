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
	// MNotSaved
	CBitVec< 10 > m_LinksTouchingSomething;
	// MNotSaved
	int32 m_nLinksTouchingSomething;
	// MNotSaved
	bool m_bApplyWind;
	// MNotSaved
	int32 m_fPrevLockedPoints;
	// MNotSaved
	int32 m_iForcePointMoveCounter;
	// MNotSaved
	bool[2] m_bPrevEndPointPos;
	// MNotSaved
	Vector[2] m_vPrevEndPointPos;
	// MNotSaved
	float32 m_flCurScroll;
	// MNetworkEnable
	// MNotSaved
	float32 m_flScrollSpeed;
	// MNetworkEnable
	// MNotSaved
	uint16 m_RopeFlags;
	// MNetworkEnable
	// MNotSaved
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_iRopeMaterialModelIndex;
	// MNetworkEnable
	// MNotSaved
	uint8 m_nSegments;
	// MNetworkEnable
	// MNotSaved
	CHandle< C_BaseEntity > m_hStartPoint;
	// MNetworkEnable
	// MNotSaved
	CHandle< C_BaseEntity > m_hEndPoint;
	// MNetworkEnable
	// MNotSaved
	AttachmentHandle_t m_iStartAttachment;
	// MNetworkEnable
	// MNotSaved
	AttachmentHandle_t m_iEndAttachment;
	// MNetworkEnable
	// MNotSaved
	uint8 m_Subdiv;
	// MNetworkEnable
	// MNetworkChangeCallback = "RecomputeSprings"
	// MNotSaved
	int16 m_RopeLength;
	// MNetworkEnable
	// MNetworkChangeCallback = "RecomputeSprings"
	// MNotSaved
	int16 m_Slack;
	// MNetworkEnable
	// MNetworkBitCount = 10
	// MNetworkMinValue = 0.100000
	// MNetworkMaxValue = 10.000000
	// MNotSaved
	float32 m_TextureScale;
	// MNetworkEnable
	// MNotSaved
	uint8 m_fLockedPoints;
	// MNetworkEnable
	// MNotSaved
	uint8 m_nChangeCount;
	// MNetworkEnable
	// MNotSaved
	float32 m_Width;
	// MNotSaved
	C_RopeKeyframe::CPhysicsDelegate m_PhysicsDelegate;
	// MNotSaved
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_hMaterial;
	// MNotSaved
	int32 m_TextureHeight;
	// MNotSaved
	Vector m_vecImpulse;
	// MNotSaved
	Vector m_vecPreviousImpulse;
	// MNotSaved
	float32 m_flCurrentGustTimer;
	// MNotSaved
	float32 m_flCurrentGustLifetime;
	// MNotSaved
	float32 m_flTimeToNextGust;
	// MNotSaved
	Vector m_vWindDir;
	// MNotSaved
	Vector m_vColorMod;
	// MNotSaved
	Vector[2] m_vCachedEndPointAttachmentPos;
	// MNotSaved
	QAngle[2] m_vCachedEndPointAttachmentAngle;
	// MNetworkEnable
	// MNotSaved
	bool m_bConstrainBetweenEndpoints;
	// MNotSaved
	bitfield:1 m_bEndPointAttachmentPositionsDirty;
	// MNotSaved
	bitfield:1 m_bEndPointAttachmentAnglesDirty;
	// MNotSaved
	bitfield:1 m_bNewDataThisFrame;
	// MNotSaved
	bitfield:1 m_bPhysicsInitted;
};
