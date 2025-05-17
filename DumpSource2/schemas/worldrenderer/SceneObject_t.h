// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class SceneObject_t
{
	uint32 m_nObjectID;
	Vector4D[3] m_vTransform;
	float32 m_flFadeStartDistance;
	float32 m_flFadeEndDistance;
	Vector4D m_vTintColor;
	CUtlString m_skin;
	ObjectTypeFlags_t m_nObjectTypeFlags;
	Vector m_vLightingOrigin;
	int16 m_nOverlayRenderOrder;
	int16 m_nLODOverride;
	int32 m_nCubeMapPrecomputedHandshake;
	int32 m_nLightProbeVolumePrecomputedHandshake;
	CStrongHandle< InfoForResourceTypeCModel > m_renderableModel;
	CStrongHandle< InfoForResourceTypeCRenderMesh > m_renderable;
};
