class C_IronSightController
{
	bool m_bIronSightAvailable;
	float32 m_flIronSightAmount;
	float32 m_flIronSightAmountGained;
	float32 m_flIronSightAmountBiased;
	float32 m_flIronSightAmount_Interpolated;
	float32 m_flIronSightAmountGained_Interpolated;
	float32 m_flIronSightAmountBiased_Interpolated;
	float32 m_flInterpolationLastUpdated;
	QAngle[8] m_angDeltaAverage;
	QAngle m_angViewLast;
	Vector2D m_vecDotCoords;
	float32 m_flDotBlur;
	float32 m_flSpeedRatio;
}
