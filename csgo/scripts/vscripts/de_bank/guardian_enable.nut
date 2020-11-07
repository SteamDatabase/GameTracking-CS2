// This function is called from the map OnMapSpawn

function EnableGuardian()
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

	   
	if (nMode == 0 && nType == 4)								// if we are running guardian, do stuff
	{
	  EntFire("buyzone.guardian", "SetEnabled", 0, 0);
	  EntFire("spawnpoints.guardian", "SetEnabled", 0,  0);
	  EntFire("spawnpoints.standard", "SetDisabled", 0, 0);
	}
	else
	{
	  EntFire("buyzone.guardian", "Disable", 0, 0); 
	}
  
 }

 
