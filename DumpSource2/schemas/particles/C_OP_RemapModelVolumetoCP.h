// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RemapModelVolumetoCP : public CParticleFunctionPreEmission
{
	// MPropertyFriendlyName = "output BBox Type"
	BBoxVolumeType_t m_nBBoxType;
	// MPropertyFriendlyName = "input control point"
	int32 m_nInControlPointNumber;
	// MPropertyFriendlyName = "output control point"
	int32 m_nOutControlPointNumber;
	// MPropertyFriendlyName = "output max control point"
	// MPropertySuppressExpr = "m_nBBoxType != BBOX_MINS_MAXS"
	int32 m_nOutControlPointMaxNumber;
	// MPropertyFriendlyName = "output CP component"
	// MPropertyAttributeChoiceName = "vector_component"
	// MPropertySuppressExpr = "m_nBBoxType != BBOX_VOLUME"
	int32 m_nField;
	// MPropertyFriendlyName = "input volume minimum in cubic units"
	// MPropertySuppressExpr = "m_nBBoxType != BBOX_VOLUME"
	float32 m_flInputMin;
	// MPropertyFriendlyName = "input volume maximum in cubic units"
	// MPropertySuppressExpr = "m_nBBoxType != BBOX_VOLUME"
	float32 m_flInputMax;
	// MPropertyFriendlyName = "output minimum"
	// MPropertySuppressExpr = "m_nBBoxType != BBOX_VOLUME"
	float32 m_flOutputMin;
	// MPropertyFriendlyName = "output maximum"
	// MPropertySuppressExpr = "m_nBBoxType != BBOX_VOLUME"
	float32 m_flOutputMax;
	// MPropertyFriendlyName = "check full bbox only"
	// MPropertySuppressExpr = "m_nBBoxType != BBOX_VOLUME"
	bool m_bBBoxOnly;
	// MPropertyFriendlyName = "cube root of volume"
	// MPropertySuppressExpr = "m_nBBoxType != BBOX_VOLUME"
	bool m_bCubeRoot;
};
