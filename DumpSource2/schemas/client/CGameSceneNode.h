// MNetworkVarNames = "CGameSceneNodeHandle m_hParent"
// MNetworkVarNames = "CNetworkOriginCellCoordQuantizedVector m_vecOrigin"
// MNetworkVarNames = "QAngle m_angRotation"
// MNetworkVarNames = "float m_flScale"
// MNetworkVarNames = "CUtlStringToken m_name"
// MNetworkVarNames = "CUtlStringToken m_hierarchyAttachName"
class CGameSceneNode
{
	CTransformWS m_nodeToWorld;
	CEntityInstance* m_pOwner;
	CGameSceneNode* m_pParent;
	CGameSceneNode* m_pChild;
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
	// MNetworkEncoder = "qangle_precise"
	// MNetworkPriority = 32
	// MNetworkSerializer = "gameSceneNodeStepSimulationAnglesSerializer"
	// MNetworkChangeCallback = "gameSceneNodeLocalAnglesChanged"
	QAngle m_angRotation;
	// MNetworkEnable
	// MNetworkChangeCallback = "gameSceneNodeLocalScaleChanged"
	// MNetworkPriority = 32
	float32 m_flScale;
	VectorWS m_vecAbsOrigin;
	QAngle m_angAbsRotation;
	float32 m_flAbsScale;
	Vector m_vecWrappedLocalOrigin;
	QAngle m_angWrappedLocalRotation;
	float32 m_flWrappedScale;
	int16 m_nParentAttachmentOrBone;
	bool m_bDebugAbsOriginChanges;
	bool m_bDormant;
	bool m_bForceParentToBeNetworked;
	bitfield:1 m_bDirtyHierarchy;
	bitfield:1 m_bDirtyBoneMergeInfo;
	bitfield:1 m_bNetworkedPositionChanged;
	bitfield:1 m_bNetworkedAnglesChanged;
	bitfield:1 m_bNetworkedScaleChanged;
	bitfield:1 m_bWillBeCallingPostDataUpdate;
	bitfield:1 m_bBoneMergeFlex;
	bitfield:2 m_nLatchAbsOrigin;
	bitfield:1 m_bDirtyBoneMergeBoneToRoot;
	uint8 m_nHierarchicalDepth;
	uint8 m_nHierarchyType;
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
