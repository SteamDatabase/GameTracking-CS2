// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MPropertyElementNameFn (UNKNOWN FOR PARSER)
class CompMatPropertyMutator_t
{
	// MPropertyAutoRebuildOnChange
	// MPropertyFriendlyName = "Enabled"
	bool m_bEnabled;
	// MPropertyAutoRebuildOnChange
	// MPropertyFriendlyName = "Mutator Command"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CompMatPropertyMutatorType_t m_nMutatorCommandType;
	// MPropertyFriendlyName = "Container to Init With"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strInitWith_Container;
	// MPropertyFriendlyName = "Input Container"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strCopyProperty_InputContainerSrc;
	// MPropertyFriendlyName = "Input Container Property"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strCopyProperty_InputContainerProperty;
	// MPropertyFriendlyName = "Target Property"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strCopyProperty_TargetProperty;
	// MPropertyFriendlyName = "Seed Input Var"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strRandomRollInputVars_SeedInputVar;
	// MPropertyFriendlyName = "Input Vars"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlVector< CUtlString > m_vecRandomRollInputVars_InputVarsToRoll;
	// MPropertyFriendlyName = "Input Container"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strCopyMatchingKeys_InputContainerSrc;
	// MPropertyFriendlyName = "Input Container"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strCopyKeysWithSuffix_InputContainerSrc;
	// MPropertyFriendlyName = "Find Suffix"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strCopyKeysWithSuffix_FindSuffix;
	// MPropertyFriendlyName = "Replace Suffix"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strCopyKeysWithSuffix_ReplaceSuffix;
	// MPropertyFriendlyName = "Value"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CompositeMaterialInputLooseVariable_t m_nSetValue_Value;
	// MPropertyFriendlyName = "Target Texture Param"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strGenerateTexture_TargetParam;
	// MPropertyFriendlyName = "Initial Container"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strGenerateTexture_InitialContainer;
	// MPropertyFriendlyName = "Resolution"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	int32 m_nResolution;
	// MPropertyAutoRebuildOnChange
	// MPropertyFriendlyName = "Scratch Target"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	bool m_bIsScratchTarget;
	// MPropertyAutoRebuildOnChange
	// MPropertyFriendlyName = "Splat Debug info on Texture"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	bool m_bSplatDebugInfo;
	// MPropertyAutoRebuildOnChange
	// MPropertyFriendlyName = "Capture in RenderDoc"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	bool m_bCaptureInRenderDoc;
	// MPropertyFriendlyName = "Texture Generation Instructions"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlVector< CompMatPropertyMutator_t > m_vecTexGenInstructions;
	// MPropertyFriendlyName = "Mutators"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlVector< CompMatPropertyMutator_t > m_vecConditionalMutators;
	// MPropertyFriendlyName = "Container to Pop"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strPopInputQueue_Container;
	// MPropertyFriendlyName = "Input Container"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strDrawText_InputContainerSrc;
	// MPropertyFriendlyName = "Input Container Property"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strDrawText_InputContainerProperty;
	// MPropertyFriendlyName = "Text Position"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	Vector2D m_vecDrawText_Position;
	// MPropertyFriendlyName = "Text Color"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	Color m_colDrawText_Color;
	// MPropertyFriendlyName = "Font"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strDrawText_Font;
	// MPropertyFriendlyName = "Conditions"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlVector< CompMatMutatorCondition_t > m_vecConditions;
};
