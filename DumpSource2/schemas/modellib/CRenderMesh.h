class CRenderMesh
{
	CUtlLeanVectorFixedGrowable< CSceneObjectData, 1 > m_sceneObjects;
	CUtlLeanVector< CBaseConstraint* > m_constraints;
	CRenderSkeleton m_skeleton;
	DynamicMeshDeformParams_t m_meshDeformParams;
	CRenderGroom* m_pGroomData;
};
