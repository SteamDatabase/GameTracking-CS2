class CTriggerImpact : public CTriggerMultiple
{
	float32 m_flMagnitude;
	float32 m_flNoise;
	float32 m_flViewkick;
	CEntityOutputTemplate< Vector > m_pOutputForce;
}
