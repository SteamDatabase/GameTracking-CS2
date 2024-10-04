class CompositeMaterialInputContainer_t
{
	bool m_bEnabled;
	CompositeMaterialInputContainerSourceType_t m_nCompositeMaterialInputContainerSourceType;
	CResourceName m_strSpecificContainerMaterial;
	CUtlString m_strAttrName;
	CUtlString m_strAlias;
	CUtlVector< CompositeMaterialInputLooseVariable_t > m_vecLooseVariables;
	CUtlString m_strAttrNameForVar;
	bool m_bExposeExternally;
}
