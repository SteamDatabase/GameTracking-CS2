// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class ClutterSceneObject_t
{
	AABB_t m_Bounds;
	ObjectTypeFlags_t m_flags;
	int16 m_nLayer;
	CUtlVector< Vector > m_instancePositions;
	CUtlVector< float32 > m_instanceScales;
	CUtlVector< Color > m_instanceTintSrgb;
	CUtlVector< ClutterTile_t > m_tiles;
	CStrongHandle< InfoForResourceTypeCModel > m_renderableModel;
	CUtlStringToken m_materialGroup;
	float32 m_flBeginCullSize;
	float32 m_flEndCullSize;
};
