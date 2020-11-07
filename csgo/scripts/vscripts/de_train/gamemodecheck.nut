// This function is called from the map OnMapSpawn

function GameModeCheck ()
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
	  EntFire("brush.blocker", "Enable", 0, 0);
	  EntFire("navblocker.2v2", "BlockNav", 0, 0);
	}
	else if (nMode == 1 && nType == 1)
	{
	  EntFire("brush.blocker", "Enable", 0, 0);				// if running demolition, do stuff
	  EntFire("navblocker.2v2", "BlockNav", 0, 0);
	}
	else
	{
	  EntFire("navblocker.2v2", "UnblockNav", 0, 0);
	}
   
 }

 
