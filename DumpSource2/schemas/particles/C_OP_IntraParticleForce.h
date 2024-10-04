class C_OP_IntraParticleForce : public CParticleFunctionForce
{
	float32 m_flAttractionMinDistance;
	float32 m_flAttractionMaxDistance;
	float32 m_flAttractionMaxStrength;
	float32 m_flRepulsionMinDistance;
	float32 m_flRepulsionMaxDistance;
	float32 m_flRepulsionMaxStrength;
	bool m_bUseAABB;
	bool m_bThreadIt;
};
