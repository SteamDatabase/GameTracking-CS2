// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_MaintainSequentialPath : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "maximum distance"
	float32 m_fMaxDistance;
	// MPropertyFriendlyName = "particles to map from start to end"
	float32 m_flNumToAssign;
	// MPropertyFriendlyName = "cohesion strength"
	float32 m_flCohesionStrength;
	// MPropertyFriendlyName = "control point movement tolerance"
	float32 m_flTolerance;
	// MPropertyFriendlyName = "restart behavior (0 = bounce, 1 = loop )"
	bool m_bLoop;
	// MPropertyFriendlyName = "use existing particle count"
	bool m_bUseParticleCount;
	CPathParameters m_PathParams;
};
