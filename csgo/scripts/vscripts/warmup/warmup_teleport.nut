ARENA1_SCRIPT <- Entities.FindByName(null, "arena1-script");
ARENA1_TSPAWN <- Entities.FindByName(null, "arena1-tspawn");
ARENA1_CTSPAWN <- Entities.FindByName(null, "arena1-ctspawn");

ARENA2_SCRIPT <- Entities.FindByName(null, "arena2-script");
ARENA2_TSPAWN <- Entities.FindByName(null, "arena2-tspawn");
ARENA2_CTSPAWN <- Entities.FindByName(null, "arena2-ctspawn");

ARENA3_SCRIPT <- Entities.FindByName(null, "arena3-script");
ARENA3_TSPAWN <- Entities.FindByName(null, "arena3-tspawn");
ARENA3_CTSPAWN <- Entities.FindByName(null, "arena3-ctspawn");

ARENA4_SCRIPT <- Entities.FindByName(null, "arena4-script");
ARENA4_TSPAWN <- Entities.FindByName(null, "arena4-tspawn");
ARENA4_CTSPAWN <- Entities.FindByName(null, "arena4-ctspawn");

ARENA5_SCRIPT <- Entities.FindByName(null, "arena5-script");
ARENA5_TSPAWN <- Entities.FindByName(null, "arena5-tspawn");
ARENA5_CTSPAWN <- Entities.FindByName(null, "arena5-ctspawn");

TSPAWN_BUSY <- false;
CTSPAWN_BUSY <- false;

SND_SPAWN <- "Player.Respawn";

WARMUP <- ScriptIsWarmupPeriod();

GAMEMODE <- ScriptGetGameMode();
GAMETYPE <- ScriptGetGameType();

WINGMAN <- false;

// type 0, mode 0 = casual
// type 0, mode 1 = competitive
// type 0, mode 2 = wingman

function Precache()
{
	self.PrecacheScriptSound( SND_SPAWN );
}

function OnPostSpawn()
{
	if (WARMUP == true && GAMEMODE == 2 && GAMETYPE == 0)		// add only for comp here
	{
		EntFireByHandle( self ,"Enable", "", 0.03, null, null );
	}
	
	if (GAMEMODE == 2 && GAMETYPE == 0)		// check if we're running wingman
	{
		WINGMAN = true;
	}
}

function TSpawnNotBusy()
{
	TSPAWN_BUSY = false;
	EntFireByHandle( self ,"Enable", "", 0.03, null, null );
//	printl ("T teleport set as Enabled!")
}

function CTSpawnNotBusy()
{
	CTSPAWN_BUSY = false;
	EntFireByHandle( self ,"Enable", "", 0.03, null, null );
//	printl ("CT teleport set as Enabled!")
}


function PlayerSpawnedT()
{

	//EntFire( self.GetName() , "Disable", "", 0 );
	EntFireByHandle( self ,"Disable", "", 0.0, null, null );

	if (TSPAWN_BUSY == false)
	{
		TSPAWN_BUSY = true;
		
		if (ARENA1_SCRIPT.GetScriptScope().AVAILABLE_TSPAWN == true)
		{
			ARENA1_SCRIPT.GetScriptScope().AVAILABLE_TSPAWN = false;
			ARENA1_SCRIPT.GetScriptScope().PLAYER_T = activator;
			activator.SetOrigin( ARENA1_TSPAWN.GetOrigin() );
			activator.SetAngles( 0, ARENA1_TSPAWN.GetAngles().y, 0 );
			EntFireByHandle( self ,"RunScriptCode", "TSpawnNotBusy()", 0.0, null, null );
		}
		else if (ARENA2_SCRIPT.GetScriptScope().AVAILABLE_TSPAWN == true)
		{
			ARENA2_SCRIPT.GetScriptScope().AVAILABLE_TSPAWN = false;
			ARENA2_SCRIPT.GetScriptScope().PLAYER_T = activator;
			activator.SetOrigin( ARENA2_TSPAWN.GetOrigin() );
			activator.SetAngles( 0, ARENA2_TSPAWN.GetAngles().y, 0 );
			EntFireByHandle( self ,"RunScriptCode", "TSpawnNotBusy()", 0.0, null, null );
		}
		else if (ARENA3_SCRIPT.GetScriptScope().AVAILABLE_TSPAWN == true && WINGMAN == false)
		{
			ARENA3_SCRIPT.GetScriptScope().AVAILABLE_TSPAWN = false;
			ARENA3_SCRIPT.GetScriptScope().PLAYER_T = activator;
			activator.SetOrigin( ARENA3_TSPAWN.GetOrigin() );
			activator.SetAngles( 0, ARENA3_TSPAWN.GetAngles().y, 0 );
			EntFireByHandle( self ,"RunScriptCode", "TSpawnNotBusy()", 0.0, null, null );
		}
		else if (ARENA4_SCRIPT.GetScriptScope().AVAILABLE_TSPAWN == true && WINGMAN == false)
		{
			ARENA4_SCRIPT.GetScriptScope().AVAILABLE_TSPAWN = false;
			ARENA4_SCRIPT.GetScriptScope().PLAYER_T = activator;
			activator.SetOrigin( ARENA4_TSPAWN.GetOrigin() );
			activator.SetAngles( 0, ARENA4_TSPAWN.GetAngles().y, 0 );
			EntFireByHandle( self ,"RunScriptCode", "TSpawnNotBusy()", 0.0, null, null );
		}
		else if (ARENA5_SCRIPT.GetScriptScope().AVAILABLE_TSPAWN == true && WINGMAN == false)
		{
			ARENA5_SCRIPT.GetScriptScope().AVAILABLE_TSPAWN = false;
			ARENA5_SCRIPT.GetScriptScope().PLAYER_T = activator;
			activator.SetOrigin( ARENA5_TSPAWN.GetOrigin() );
			activator.SetAngles( 0, ARENA5_TSPAWN.GetAngles().y, 0 );
			EntFireByHandle( self ,"RunScriptCode", "TSpawnNotBusy()", 0.0, null, null );
		}
		else
		{
			//EntFire( self.GetName() ,"RunScriptCode", "TSpawnNotBusy()", 0 );
			EntFireByHandle( self ,"RunScriptCode", "TSpawnNotBusy()", 0.0, null, null );
		}
		
		activator.EmitSound(SND_SPAWN);
	}
}

function PlayerSpawnedCT()
{

	//EntFire( self.GetName() , "Disable", "", 0 );
	EntFireByHandle( self ,"Disable", "", 0.0, null, null );

	if (CTSPAWN_BUSY == false)
	{
		CTSPAWN_BUSY = true;
	
		if (ARENA1_SCRIPT.GetScriptScope().AVAILABLE_CTSPAWN == true)
		{
			ARENA1_SCRIPT.GetScriptScope().AVAILABLE_CTSPAWN = false;
			ARENA1_SCRIPT.GetScriptScope().PLAYER_CT = activator;
			activator.SetOrigin( ARENA1_CTSPAWN.GetOrigin() );
			activator.SetAngles( 0, ARENA1_CTSPAWN.GetAngles().y, 0 );
			EntFireByHandle( self ,"RunScriptCode", "CTSpawnNotBusy()", 0.0, null, null );
		}
		else if (ARENA2_SCRIPT.GetScriptScope().AVAILABLE_CTSPAWN == true)
		{
			ARENA2_SCRIPT.GetScriptScope().AVAILABLE_CTSPAWN = false;
			ARENA2_SCRIPT.GetScriptScope().PLAYER_CT = activator;
			activator.SetOrigin( ARENA2_CTSPAWN.GetOrigin() );
			activator.SetAngles( 0, ARENA2_CTSPAWN.GetAngles().y, 0 );
			EntFireByHandle( self ,"RunScriptCode", "CTSpawnNotBusy()", 0.0, null, null );
		}
		else if (ARENA3_SCRIPT.GetScriptScope().AVAILABLE_CTSPAWN == true && WINGMAN == false)
		{
			ARENA3_SCRIPT.GetScriptScope().AVAILABLE_CTSPAWN = false;
			ARENA3_SCRIPT.GetScriptScope().PLAYER_CT = activator;
			activator.SetOrigin( ARENA3_CTSPAWN.GetOrigin() );
			activator.SetAngles( 0, ARENA3_CTSPAWN.GetAngles().y, 0 );
			EntFireByHandle( self ,"RunScriptCode", "CTSpawnNotBusy()", 0.0, null, null );
		}
		else if (ARENA4_SCRIPT.GetScriptScope().AVAILABLE_CTSPAWN == true && WINGMAN == false)
		{
			ARENA4_SCRIPT.GetScriptScope().AVAILABLE_CTSPAWN = false;
			ARENA4_SCRIPT.GetScriptScope().PLAYER_CT = activator;
			activator.SetOrigin( ARENA4_CTSPAWN.GetOrigin() );
			activator.SetAngles( 0, ARENA4_CTSPAWN.GetAngles().y, 0 );
			EntFireByHandle( self ,"RunScriptCode", "CTSpawnNotBusy()", 0.0, null, null );
		}
		else if (ARENA5_SCRIPT.GetScriptScope().AVAILABLE_CTSPAWN == true && WINGMAN == false)
		{
			ARENA5_SCRIPT.GetScriptScope().AVAILABLE_CTSPAWN = false;
			ARENA5_SCRIPT.GetScriptScope().PLAYER_CT = activator;
			activator.SetOrigin( ARENA5_CTSPAWN.GetOrigin() );
			activator.SetAngles( 0, ARENA5_CTSPAWN.GetAngles().y, 0 );
			EntFireByHandle( self ,"RunScriptCode", "CTSpawnNotBusy()", 0.0, null, null );
		}
		else
		{
			EntFireByHandle( self ,"RunScriptCode", "CTSpawnNotBusy()", 0.0, null, null );
		}

		activator.EmitSound(SND_SPAWN);
	}
}
