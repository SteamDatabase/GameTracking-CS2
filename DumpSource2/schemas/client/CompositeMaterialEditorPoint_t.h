// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CompositeMaterialEditorPoint_t
{
	// MPropertyGroupName = "Preview Model"
	// MPropertyFriendlyName = "Target Model"
	// MPropertyAttributeEditor = "AssetBrowse( vmdl )"
	CResourceName m_ModelName;
	// MPropertyGroupName = "Preview Model"
	// MPropertyFriendlyName = "Animation"
	int32 m_nSequenceIndex;
	// MPropertyGroupName = "Preview Model"
	// MPropertyFriendlyName = "Animation Cycle"
	// MPropertyAttributeRange = "0.0 1.0"
	float32 m_flCycle;
	// MPropertyGroupName = "Preview Model"
	// MPropertyFriendlyName = "Model Preview State"
	// MPropertyAttributeEditor = "CompositeMaterialUserModelStateSetting"
	KeyValues3 m_KVModelStateChoices;
	// MPropertyAutoRebuildOnChange
	// MPropertyGroupName = "Preview Model"
	// MPropertyFriendlyName = "Enable Child Model"
	bool m_bEnableChildModel;
	// MPropertyGroupName = "Preview Model"
	// MPropertyFriendlyName = "Child Model"
	// MPropertyAttributeEditor = "AssetBrowse( vmdl )"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CResourceName m_ChildModelName;
	// MPropertyGroupName = "Composite Material Assembly"
	// MPropertyFriendlyName = "Composite Material Assembly Procedures"
	CUtlVector< CompositeMaterialAssemblyProcedure_t > m_vecCompositeMaterialAssemblyProcedures;
	// MPropertyFriendlyName = "Generated Composite Materials"
	CUtlVector< CompositeMaterial_t > m_vecCompositeMaterials;
};
