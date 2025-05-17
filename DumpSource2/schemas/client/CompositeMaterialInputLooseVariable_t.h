// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MPropertyElementNameFn (UNKNOWN FOR PARSER)
class CompositeMaterialInputLooseVariable_t
{
	// MPropertyFriendlyName = "Name"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strName;
	// MPropertyAutoRebuildOnChange
	// MPropertyFriendlyName = "Expose Externally"
	bool m_bExposeExternally;
	// MPropertyFriendlyName = "Exposed Friendly Name"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strExposedFriendlyName;
	// MPropertyFriendlyName = "Exposed Friendly Group"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strExposedFriendlyGroupName;
	// MPropertyFriendlyName = "Exposed Fixed Range"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	bool m_bExposedVariableIsFixedRange;
	// MPropertyFriendlyName = "Exposed SetVisible When True"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strExposedVisibleWhenTrue;
	// MPropertyFriendlyName = "Exposed SetHidden When True"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strExposedHiddenWhenTrue;
	// MPropertyFriendlyName = "Exposed Value List"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strExposedValueList;
	// MPropertyAutoRebuildOnChange
	// MPropertyFriendlyName = "Type"
	CompositeMaterialInputLooseVariableType_t m_nVariableType;
	// MPropertyFriendlyName = "Value"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	bool m_bValueBoolean;
	// MPropertyFriendlyName = "X Value"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	// MPropertyAttributeRange = "0 255"
	int32 m_nValueIntX;
	// MPropertyFriendlyName = "Y Value"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	// MPropertyAttributeRange = "0 255"
	int32 m_nValueIntY;
	// MPropertyFriendlyName = "Z Value"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	// MPropertyAttributeRange = "0 255"
	int32 m_nValueIntZ;
	// MPropertyFriendlyName = "W Value"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	// MPropertyAttributeRange = "0 255"
	int32 m_nValueIntW;
	// MPropertyFriendlyName = "Specify Min/Max"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	bool m_bHasFloatBounds;
	// MPropertyFriendlyName = "X Value"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	// MPropertyAttributeRange = "0.0 1.0"
	float32 m_flValueFloatX;
	// MPropertyFriendlyName = "X Min"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	float32 m_flValueFloatX_Min;
	// MPropertyFriendlyName = "X Max"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	float32 m_flValueFloatX_Max;
	// MPropertyFriendlyName = "Y Value"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	// MPropertyAttributeRange = "0.0 1.0"
	float32 m_flValueFloatY;
	// MPropertyFriendlyName = "Y Min"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	float32 m_flValueFloatY_Min;
	// MPropertyFriendlyName = "Y Max"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	float32 m_flValueFloatY_Max;
	// MPropertyFriendlyName = "Z Value"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	// MPropertyAttributeRange = "0.0 1.0"
	float32 m_flValueFloatZ;
	// MPropertyFriendlyName = "Z Min"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	float32 m_flValueFloatZ_Min;
	// MPropertyFriendlyName = "Z Max"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	float32 m_flValueFloatZ_Max;
	// MPropertyFriendlyName = "W Value"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	// MPropertyAttributeRange = "0.0 1.0"
	float32 m_flValueFloatW;
	// MPropertyFriendlyName = "W Min"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	float32 m_flValueFloatW_Min;
	// MPropertyFriendlyName = "W Max"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	float32 m_flValueFloatW_Max;
	// MPropertyFriendlyName = "Value"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	Color m_cValueColor4;
	// MPropertyFriendlyName = "Value"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CompositeMaterialVarSystemVar_t m_nValueSystemVar;
	// MPropertyFriendlyName = "Material"
	// MPropertyAttributeEditor = "AssetBrowse( vmat, *IncrementalUpdate )"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CResourceName m_strResourceMaterial;
	// MPropertyFriendlyName = "Texture"
	// MPropertyAttributeEditor = "AssetBrowse( jpg, png, psd, tga )"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strTextureContentAssetPath;
	// MPropertyHideField
	CResourceName m_strTextureRuntimeResourcePath;
	// MPropertyHideField
	CUtlString m_strTextureCompilationVtexTemplate;
	// MPropertyFriendlyName = "Texture Type"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CompositeMaterialInputTextureType_t m_nTextureType;
	// MPropertyFriendlyName = "String"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strString;
	// MPropertyFriendlyName = "Layout XML"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strPanoramaPanelPath;
	// MPropertyFriendlyName = "Render Resolution"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	int32 m_nPanoramaRenderRes;
};
