class CRagdollComponentUpdater : public CAnimComponentUpdater
{
	CUtlVector< CAnimNodePath > m_ragdollNodePaths;
	CUtlVector< int32 > m_boneIndices;
	CUtlVector< CUtlString > m_boneNames;
	CUtlVector< WeightList > m_weightLists;
	float32 m_flSpringFrequencyMin;
	float32 m_flSpringFrequencyMax;
	float32 m_flMaxStretch;
	bool m_bSolidCollisionAtZeroWeight;
}
