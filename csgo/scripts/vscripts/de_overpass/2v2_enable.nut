// This function is called from the map OnMapSpawn

function EnableWingman()
{
       // checks the game mode and type and the current match
       local nMode = ScriptGetGameMode();
       local nType = ScriptGetGameType();

       // type 0, mode 0 = casual
       // type 0, mode 1 = competitive
       // type 1, mode 0 = arms race
       // type 1, mode 1 = demolition
       // type 1, mode 2 = deathmatch
       // etc 

	   
	if (nMode == 2 && nType == 0)								// if we are running 2v2, do stuff
	{
	  EntFire("spawnpoints.standard.ct", "SetDisabled", 0, 0);
	  EntFire("spawnpoints.standard.t", "SetDisabled", 0, 0);
	  EntFire("spawnpoints.2v2", "SetEnabled", 0, 0);
	  EntFire("brush.blocker", "Enable", 0, 0);
	  EntFire("buyzone.2v2", "SetEnabled", 0, 0);
	  EntFire("navblocker.2v2", "BlockNav", 0, 0);
	}
	else
	{
	  EntFire("buyzone.2v2", "Disable", 0, 0);				// disable 2v2 buyzones
	  EntFire("navblocker.2v2", "UnblockNav", 0, 0);
	}
  
 }

 
