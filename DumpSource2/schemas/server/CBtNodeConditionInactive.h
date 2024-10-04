class CBtNodeConditionInactive : public CBtNodeCondition
{
	float32 m_flRoundStartThresholdSeconds;
	float32 m_flSensorInactivityThresholdSeconds;
	CountdownTimer m_SensorInactivityTimer;
};
