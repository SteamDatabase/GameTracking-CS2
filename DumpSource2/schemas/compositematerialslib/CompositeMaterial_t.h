// MPropertyElementNameFn (UNKNOWN FOR PARSER)
class CompositeMaterial_t
{
	// MPropertyGroupName = "Target Material"
	// MPropertyAttributeEditor = "CompositeMaterialKVInspector"
	KeyValues3 m_TargetKVs;
	// MPropertyGroupName = "Pre-Generated Output Material"
	// MPropertyAttributeEditor = "CompositeMaterialKVInspector"
	KeyValues3 m_PreGenerationKVs;
	// MPropertyGroupName = "Generated Composite Material"
	// MPropertyAttributeEditor = "CompositeMaterialKVInspector"
	KeyValues3 m_FinalKVs;
	// MPropertyFriendlyName = "Generated Textures"
	CUtlVector< GeneratedTextureHandle_t > m_vecGeneratedTextures;
};
