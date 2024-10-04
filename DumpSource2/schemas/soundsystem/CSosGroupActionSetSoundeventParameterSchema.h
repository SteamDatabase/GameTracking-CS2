class CSosGroupActionSetSoundeventParameterSchema : public CSosGroupActionSchema
{
	int32 m_nMaxCount;
	float32 m_flMinValue;
	float32 m_flMaxValue;
	CUtlString m_opvarName;
	SosActionSortType_t m_nSortType;
};
