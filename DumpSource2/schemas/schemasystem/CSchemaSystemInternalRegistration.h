class CSchemaSystemInternalRegistration
{
	Vector2D m_Vector2D;
	Vector m_Vector;
	VectorWS m_VectorWS;
	VectorAligned m_VectorAligned;
	Quaternion m_Quaternion;
	QAngle m_QAngle;
	RotationVector m_RotationVector;
	RadianEuler m_RadianEuler;
	DegreeEuler m_DegreeEuler;
	QuaternionStorage m_QuaternionStorage;
	matrix3x4_t m_matrix3x4_t;
	matrix3x4a_t m_matrix3x4a_t;
	Color m_Color;
	Vector4D m_Vector4D;
	CTransform m_CTransform;
	KeyValues* m_pKeyValues;
	CUtlBinaryBlock m_CUtlBinaryBlock;
	CUtlString m_CUtlString;
	CUtlSymbol m_CUtlSymbol;
	CUtlStringToken m_stringToken;
	CUtlStringTokenWithStorage m_stringTokenWithStorage;
	CResourceArray< CResourcePointer< CResourceString > > m_ResourceTypes;
	KeyValues3 m_KV3;
};
