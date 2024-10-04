class CompositeMaterialEditorPoint_t
{
	CResourceName m_ModelName;
	int32 m_nSequenceIndex;
	float32 m_flCycle;
	KeyValues3 m_KVModelStateChoices;
	bool m_bEnableChildModel;
	CResourceName m_ChildModelName;
	CUtlVector< CompositeMaterialAssemblyProcedure_t > m_vecCompositeMaterialAssemblyProcedures;
	CUtlVector< CompositeMaterial_t > m_vecCompositeMaterials;
};
