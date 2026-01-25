// MNetworkVarNames = "CGameSceneNodeHandle m_hParent"
// MNetworkVarNames = "CNetworkOriginCellCoordQuantizedVector m_vecOrigin"
// MNetworkVarNames = "QAngle m_angRotation"
// MNetworkVarNames = "float m_flScale"
// MNetworkVarNames = "CUtlStringToken m_name"
// MNetworkVarNames = "CUtlStringToken m_hierarchyAttachName"
class CGameSceneNode
{
	// MNotSaved
	CTransformWS m_nodeToWorld;
	// MNotSaved
	CEntityInstance* m_pOwner;
	// MNotSaved
	CGameSceneNode* m_pParent;
	// MNotSaved
	CGameSceneNode* m_pChild;
	// MNotSaved
	CGameSceneNode* m_pNextSibling;
	// MNetworkEnable
	// MNetworkSerializer = "gameSceneNode"
	// MNetworkChangeCallback = "gameSceneNodeHierarchyParentChanged"
	// MNetworkPriority = 32
	// MNetworkVarEmbeddedFieldOffsetDelta = 8
	CGameSceneNodeHandle m_hParent;
	// MNetworkEnable
	// MNetworkPriority = 32
	// MNetworkUserGroup = "Origin"
	// MNetworkChangeCallback = "gameSceneNodeLocalOriginChanged"
	CNetworkOriginCellCoordQuantizedVector m_vecOrigin;
	// MNetworkEnable
	// MNetworkPriority = 32
	// MNetworkSerializer = "gameSceneNodeStepSimulationAnglesSerializer"
	// MNetworkChangeCallback = "gameSceneNodeLocalAnglesChanged"
	// MNetworkEncoder = "qangle_precise"
	QAngle m_angRotation;
	// MNetworkEnable
	// MNetworkChangeCallback = "gameSceneNodeLocalScaleChanged"
	// MNetworkPriority = 32
	float32 m_flScale;
	VectorWS m_vecAbsOrigin;
	QAngle m_angAbsRotation;
	float32 m_flAbsScale;
	// MNotSaved
	Vector m_vecWrappedLocalOrigin;
	// MNotSaved
	QAngle m_angWrappedLocalRotation;
	// MNotSaved
	float32 m_flWrappedScale;
	// MNotSaved
	int16 m_nParentAttachmentOrBone;
	// MNotSaved
	bool m_bDebugAbsOriginChanges;
	bool m_bDormant;
	bool m_bForceParentToBeNetworked;
	// MNotSaved
	bitfield:1 m_bDirtyHierarchy;
	// MNotSaved
	bitfield:1 m_bDirtyBoneMergeInfo;
	// MNotSaved
	bitfield:1 m_bNetworkedPositionChanged;
	// MNotSaved
	bitfield:1 m_bNetworkedAnglesChanged;
	// MNotSaved
	bitfield:1 m_bNetworkedScaleChanged;
	// MNotSaved
	bitfield:1 m_bWillBeCallingPostDataUpdate;
	// MNotSaved
	bitfield:1 m_bBoneMergeFlex;
	// MNotSaved
	bitfield:2 m_nLatchAbsOrigin;
	// MNotSaved
	bitfield:1 m_bDirtyBoneMergeBoneToRoot;
	// MNotSaved
	uint8 m_nHierarchicalDepth;
	// MNotSaved
	uint8 m_nHierarchyType;
	// MNotSaved
	uint8 m_nDoNotSetAnimTimeInInvalidatePhysicsCount;
	// MNetworkEnable
	CUtlStringToken m_name;
	// MNetworkEnable
	// MNetworkChangeCallback = "gameSceneNodeHierarchyAttachmentChanged"
	CUtlStringToken m_hierarchyAttachName;
	float32 m_flZOffset;
	float32 m_flClientLocalScale;
	Vector m_vRenderOrigin;
};
