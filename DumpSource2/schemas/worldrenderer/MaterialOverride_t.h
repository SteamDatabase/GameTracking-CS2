// MGetKV3ClassDefaults = {
//	"m_nSceneObjectIndex": 0,
//	"m_nSubSceneObject": 0,
//	"m_nDrawCallIndex": 0,
//	"m_pMaterial": "",
//	"m_vLinearTintColor":
//	[
//		1.000000,
//		1.000000,
//		1.000000
//	]
//}
class MaterialOverride_t : public BaseSceneObjectOverride_t
{
	uint32 m_nSubSceneObject;
	uint32 m_nDrawCallIndex;
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_pMaterial;
	Vector m_vLinearTintColor;
};
