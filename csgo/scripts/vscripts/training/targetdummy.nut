m_TranslationBoard <- EntityGroup[0].GetName()
m_RotationBoard1 <- EntityGroup[1].GetName()
m_RotationBoard2 <- EntityGroup[2].GetName()



function TargetDucking_HIT()
{
	EntFire( m_RotationBoard1, "Open", "", 0 )
	EntFire( m_RotationBoard2, "Open", "", 0 )
}

function TargetDucking_REVEAL()
{
	EntFire( m_RotationBoard1, "Close", "", 0 )
	EntFire( m_RotationBoard2, "Close", "", 0 )
	EntFire( m_TranslationBoard, "Open", "", 0 )
}

function GiveGun()
{
	EntFire( "command", "command", "give weapon_m4a1", 0 )
}