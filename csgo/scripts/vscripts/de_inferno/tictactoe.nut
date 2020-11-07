// 128 tic tac csgo

TEXTURETOGGLE <- EntityGroup[0];
PFX_CONFETTI <- EntityGroup[1];

PLAYER1 <- null;
PLAYER2 <- null;

LASTPLAYED <- null;

ENABLED <- false;

SND_WIN_SOUND <- "BrassBell.E";
SND_DRAWING <- "CT_Sand.StepRight";



//Grid layout:
//Grid1 Grid2 Grid3
//Grid4 Grid5 Grid6
//Grid7 Grid8 Grid9

GRID1 <- null;
GRID2 <- null;
GRID3 <- null;
GRID4 <- null;
GRID5 <- null;
GRID6 <- null;
GRID7 <- null;
GRID8 <- null;
GRID9 <- null;

function Precache()
{
	self.PrecacheScriptSound( SND_WIN_SOUND );
	self.PrecacheScriptSound( SND_DRAWING );
}

function Test()
{
self.EmitSound(SND_DRAWING);
}

function GridActivated(id)		// id is what grid is being activated, 1-9
{

local userindex = activator.entindex();

// player check (including initial setup)
if (PLAYER1 == null || userindex == PLAYER1 && LASTPLAYED != PLAYER1)	
	{
	PLAYER1 = userindex;
	SetGridOwner(id, PLAYER1);
	}
	else if (PLAYER2 == null && userindex != PLAYER1 || userindex == PLAYER2 && LASTPLAYED != PLAYER2)
		{
		PLAYER2 = userindex;
		SetGridOwner(id, PLAYER2);
		}
	
}

function SetGridOwner(id, owner)
{

	switch ( id )
	{
		case 1: 	
			if (GRID1 == null)
			{
			GRID1 = owner;
			LASTPLAYED = owner;
			TEXTURETOGGLE.__KeyValueFromString("target", "@overlay_grid1");
			UpdateTexture(owner);
			}
			break;
		case 2:			
			if (GRID2 == null)
			{
			GRID2 = owner;
			LASTPLAYED = owner;
			TEXTURETOGGLE.__KeyValueFromString("target", "@overlay_grid2");
			UpdateTexture(owner);
			}
			break;
		case 3:
			if (GRID3 == null)
			{
			GRID3 = owner;
			LASTPLAYED = owner;
			TEXTURETOGGLE.__KeyValueFromString("target", "@overlay_grid3");
			UpdateTexture(owner);
			}
			break;
		case 4:		
			if (GRID4 == null)
			{
			GRID4 = owner;
			LASTPLAYED = owner;
			TEXTURETOGGLE.__KeyValueFromString("target", "@overlay_grid4");
			UpdateTexture(owner);
			}
			break;
		case 5:			
			if (GRID5 == null)
			{
			GRID5 = owner;
			LASTPLAYED = owner;
			TEXTURETOGGLE.__KeyValueFromString("target", "@overlay_grid5");
			UpdateTexture(owner);
			}
			break;
		case 6:
			if (GRID6 == null)
			{
			GRID6 = owner;
			LASTPLAYED = owner;
			TEXTURETOGGLE.__KeyValueFromString("target", "@overlay_grid6");
			UpdateTexture(owner);
			}
			break;
		case 7:			
			if (GRID7 == null)
			{
			GRID7 = owner;
			LASTPLAYED = owner;
			TEXTURETOGGLE.__KeyValueFromString("target", "@overlay_grid7");
			UpdateTexture(owner);
			}
			break;
		case 8:		
			if (GRID8 == null)
			{
			GRID8 = owner;
			LASTPLAYED = owner;
			TEXTURETOGGLE.__KeyValueFromString("target", "@overlay_grid8");
			UpdateTexture(owner);
			}
			break;
		case 9:	
			if (GRID9 == null)
			{
			GRID9 = owner;
			LASTPLAYED = owner;
			TEXTURETOGGLE.__KeyValueFromString("target", "@overlay_grid9");
			UpdateTexture(owner);
			}
			break;
		
	}
	
}

function UpdateTexture(owner)
{
			if (owner == PLAYER1)
			{
			EntFireByHandle(TEXTURETOGGLE, "SetTextureIndex", "1", 0, null, null);	
			}
			else
				{
				EntFireByHandle(TEXTURETOGGLE, "SetTextureIndex", "2", 0, null, null);	
				}

			self.EmitSound(SND_DRAWING);
				
			CheckState(owner);		// check state of game
}

function CheckState(owner)
{

if (GRID1 == owner && GRID2 == owner && GRID3 == owner || GRID4 == owner && GRID5 == owner && GRID6 == owner || GRID7 == owner && GRID8 == owner && GRID9 == owner)
	{
	//printl ("Horizontal win!");
	GameWon();
	}
	else if (GRID1 == owner && GRID4 == owner && GRID7 == owner || GRID2 == owner && GRID5 == owner && GRID8 == owner || GRID3 == owner && GRID6 == owner && GRID9 == owner)
		{
		//printl ("Vertical win!");
		GameWon();
		}
		else if (GRID1 == owner && GRID5 == owner && GRID9 == owner || GRID3 == owner && GRID5 == owner && GRID7 == owner)
			{
			//printl ("Cross win!");
			GameWon();
			}
			else if (GRID1 != null && GRID2 != null && GRID3 != null && GRID4 != null && GRID5 != null && GRID6 != null && GRID7 != null && GRID8 != null && GRID9 != null)
				{
				//printl ("DRAW!");
				GameDraw();
				}
}

function GameWon()
{
//EntFireByHandle(PFX_CONFETTI, "Start", "", 0, null, null);	
//EntFireByHandle(PFX_CONFETTI, "Stop", "", 1, null, null);	

self.EmitSound(SND_WIN_SOUND);

EntFireByHandle(self, "Runscriptcode", "ResetGame()", 3, null, null);	
}

function GameDraw()
{
EntFireByHandle(self, "Runscriptcode", "ResetGame()", 3, null, null);	
}

function ResetGame()
{
PLAYER1 = null;
PLAYER2 = null;

LASTPLAYED = null;

GRID1 = null;
GRID2 = null;
GRID3 = null;
GRID4 = null;
GRID5 = null;
GRID6 = null;
GRID7 = null;
GRID8 = null;
GRID9 = null;

TEXTURETOGGLE.__KeyValueFromString("target", "@overlay_grid*");
EntFireByHandle(TEXTURETOGGLE, "SetTextureIndex", "0", 0, null, null);	
}


/*

TODO: 


*/