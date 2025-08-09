// MGetKV3ClassDefaults = {
//	"m_nObjectID": 0,
//	"m_vTransform":
//	[
//		[
//			0.000000,
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		[
//			0.000000,
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		[
//			0.000000,
//			0.000000,
//			0.000000,
//			0.000000
//		]
//	],
//	"m_flFadeStartDistance": 0.000000,
//	"m_flFadeEndDistance": 0.000000,
//	"m_vTintColor":
//	[
//		1.000000,
//		1.000000,
//		1.000000,
//		1.000000
//	],
//	"m_skin": "",
//	"m_nObjectTypeFlags": "OBJECT_TYPE_MODEL",
//	"m_vLightingOrigin":
//	[
//		340282346638528859811704183484516925440.000000,
//		340282346638528859811704183484516925440.000000,
//		340282346638528859811704183484516925440.000000
//	],
//	"m_nOverlayRenderOrder": 0,
//	"m_nLODOverride": -1,
//	"m_nCubeMapPrecomputedHandshake": 0,
//	"m_nLightProbeVolumePrecomputedHandshake": 0,
//	"m_renderableModel": "",
//	"m_renderable": ""
//}
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
