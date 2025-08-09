// MGetKV3ClassDefaults = {
//	"m_transform":
//	[
//		1.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000,
//		0.000000
//	],
//	"m_flWidth": 0.000000,
//	"m_flHeight": 0.000000,
//	"m_flDepth": 0.000000,
//	"m_vUVStart":
//	[
//		0.000000,
//		0.000000
//	],
//	"m_vUVEnd":
//	[
//		0.000000,
//		0.000000
//	],
//	"m_pMaterial": "",
//	"m_nRenderOrder": 0,
//	"m_vTintColor":
//	[
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_nSequenceOverride": -1
//}
class InfoOverlayData_t
{
	matrix3x4_t m_transform;
	float32 m_flWidth;
	float32 m_flHeight;
	float32 m_flDepth;
	Vector2D m_vUVStart;
	Vector2D m_vUVEnd;
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_pMaterial;
	int32 m_nRenderOrder;
	Vector4D m_vTintColor;
	int32 m_nSequenceOverride;
};
