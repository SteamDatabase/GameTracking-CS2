///////
///////
///////

function PlayerEnterTestArea()
{
	EntFire ( "@radiovoice","RunScriptCode", "BombIntro()", 0 )
}

function PlayerPickedUpBomb()
{
	ScriptSetRadarHidden( false )
	EntFire ( "@radiovoice","RunScriptCode", "BombTakeBomb()", 0 )
}

function PlantedBombAtA()
{
	EntFire ( "@radiovoice","RunScriptCode", "BombPlantA()", 0 )

}

function OnBombBeginDefused()
{
	EntFire ( "@radiovoice","RunScriptCode", "BombBeingDefused()", 0 )
}

function OnBombDefused()
{
	EntFire ( "@radiovoice","RunScriptCode", "BombDefused()", 0 )
}

function OnBombExploded()
{
	EntFire ( "@radiovoice","RunScriptCode", "BombExploded()", 0 )
}