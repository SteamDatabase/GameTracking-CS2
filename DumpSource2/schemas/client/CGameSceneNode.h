// MNetworkVarNames = "CGameSceneNodeHandle m_hParent"
// MNetworkVarNames = "CNetworkOriginCellCoordQuantizedVector m_vecOrigin"
// MNetworkVarNames = "QAngle m_angRotation"
// MNetworkVarNames = "float m_flScale"
// MNetworkVarNames = "CUtlStringToken m_name"
// MNetworkVarNames = "CUtlStringToken m_hierarchyAttachName"
class CGameSceneNode
{
	// MNetworkDisable
	CTransform m_nodeToWorld;
	// MNetworkDisable
	CEntityInstance* m_pOwner;
	// MNetworkDisable
	CGameSceneNode* m_pParent;
	// MNetworkDisable
	CGameSceneNode* m_pChild;
	// MNetworkDisable
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
	// MNetworkDisable
	Vector m_vecAbsOrigin;
	// MNetworkDisable
	QAngle m_angAbsRotation;
	// MNetworkDisable
	float32 m_flAbsScale;
	// MNetworkDisable
	int16 m_nParentAttachmentOrBone;
	// MNetworkDisable
	bool m_bDebugAbsOriginChanges;
	// MNetworkDisable
	bool m_bDormant;
	// MNetworkDisable
	bool m_bForceParentToBeNetworked;
	// MNetworkDisable
	bitfield:1 m_bDirtyHierarchy;
	// MNetworkDisable
	bitfield:1 m_bDirtyBoneMergeInfo;
	// MNetworkDisable
	bitfield:1 m_bNetworkedPositionChanged;
	// MNetworkDisable
	bitfield:1 m_bNetworkedAnglesChanged;
	// MNetworkDisable
	bitfield:1 m_bNetworkedScaleChanged;
	// MNetworkDisable
	bitfield:1 m_bWillBeCallingPostDataUpdate;
	// MNetworkDisable
	bitfield:1 m_bBoneMergeFlex;
	// MNetworkDisable
	bitfield:2 m_nLatchAbsOrigin;
	// MNetworkDisable
	bitfield:1 m_bDirtyBoneMergeBoneToRoot;
	// MNetworkDisable
	uint8 m_nHierarchicalDepth;
	// MNetworkDisable
	uint8 m_nHierarchyType;
	// MNetworkDisable
	uint8 m_nDoNotSetAnimTimeInInvalidatePhysicsCount;
	// MNetworkEnable
	CUtlStringToken m_name;
	// MNetworkEnable
	// MNetworkChangeCallback = "gameSceneNodeHierarchyAttachmentChanged"
	CUtlStringToken m_hierarchyAttachName;
	// MNetworkDisable
	float32 m_flZOffset;
	// MNetworkDisable
	float32 m_flClientLocalScale;
	// MNetworkDisable
	Vector m_vRenderOrigin;
};
