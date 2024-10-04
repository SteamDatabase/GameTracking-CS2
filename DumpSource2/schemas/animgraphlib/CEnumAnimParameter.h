class CEnumAnimParameter : public CConcreteAnimParameter
{
	uint8 m_defaultValue;
	CUtlVector< CUtlString > m_enumOptions;
	CUtlVector< uint64 > m_vecEnumReferenced;
};
