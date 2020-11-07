m_Button1 <- EntityGroup[0];
m_Button1_mdl <- EntityGroup[1];
m_Button2 <- EntityGroup[2];
m_Button2_mdl <- EntityGroup[3];
m_Button1_spr <- EntityGroup[4];
m_Button2_spr <- EntityGroup[5];

v_Active <- false;
v_Enabled <- false;	

v_ResetGracePeriod <- 0.75;
v_ResetTime <-	0;

v_Debug <- false;		// if true, only requires one button press to succeed

BUTTON1_ACTIVATOR <- 0;
BUTTON2_ACTIVATOR <- 0;

// if buttons are pressed or not
BUTTON1 <- false;
BUTTON2 <- false;


SND_BUTTON_PRESSED <- "buttons/button24.wav";
SND_BUTTON_RESET <- "buttons/button5.wav";
SND_SUCCESS <- "buttons/button5.wav";
SND_EXPIRED <- "buttons/button8.wav";


function Precache()
{
	self.PrecacheScriptSound( SND_BUTTON_PRESSED );
	self.PrecacheScriptSound( SND_BUTTON_RESET );
	self.PrecacheScriptSound( SND_SUCCESS );
	self.PrecacheScriptSound( SND_EXPIRED );

}

function Think()
{
//printl ("Time is: " + Time() );

	if (v_Enabled == true && v_Active == true && Time() >=  v_ResetTime)
		{
		//printl ("Buttons expired");
		self.EmitSound( SND_EXPIRED );
		v_Active = false;
		Reset();
		}
	
			if (v_Enabled == true && v_Active == true && Time() <= v_ResetTime && BUTTON1 == true && BUTTON2 == true && BUTTON1_ACTIVATOR != BUTTON2_ACTIVATOR )		// sheesh
				{
				EntFire( "!self", "FireUser1", "", 0 );		// trigger success relay
				self.EmitSound( SND_SUCCESS );
				v_Active = false;
				Enabled ( false );
				EntFire( m_Button1.GetName(), "Lock", "", 0 );
				EntFire( m_Button2.GetName(), "Lock", "", 0 );
				//printl ("Coop button success");
				//Reset();
				}
				
					if (v_Enabled == true && v_Debug == true && v_Active == true)
						{
						//printl ("Coop button debug triggered");
						EntFire( "!self", "FireUser1", "", 0 );		// trigger success relay
						self.EmitSound( SND_SUCCESS );
						v_Active = false;
						Enabled ( false );
						EntFire( m_Button1.GetName(), "Lock", "", 0 );
						EntFire( m_Button2.GetName(), "Lock", "", 0 );
						//printl ("Coop button success");
						}
						

}

function DebugEnable()
{
v_Debug = true;
//printl ("Coop button debug enable");
}

function Enabled( bool )
{

	if (bool == true)
		{
		v_Enabled = true;
		EntFire( m_Button1.GetName(), "Unlock", "", 1 );
		EntFire( m_Button2.GetName(), "Unlock", "", 1 );
		EntFire( m_Button1_spr.GetName(), "ShowSprite", "", 1 );
		EntFire( m_Button2_spr.GetName(), "ShowSprite", "", 1 );
		}
		
			if (bool == false)
				{
				v_Enabled = false;
				EntFire( m_Button1.GetName(), "Lock", "", 0 );
				EntFire( m_Button2.GetName(), "Lock", "", 0 );
				}

}


function ButtonPushed( input )
{

local ply = activator;
//printl ("Activator is : " + ply);


	if (v_Active == false)
		{
		v_ResetTime = Time() + v_ResetGracePeriod;
		v_Active = true;
//		printl ("Reset time is: " + v_ResetTime);
		}

		if (input == 1)
			{
			BUTTON1 = true;
			EntFire( m_Button1_mdl.GetName(), "SetAnimation", "turn_ON", 0 );
			m_Button1.EmitSound ( SND_BUTTON_PRESSED );
			BUTTON1_ACTIVATOR = ply;
			}

		if (input == 2)
			{
			BUTTON2 = true;
			EntFire( m_Button2_mdl.GetName(), "SetAnimation", "turn_ON", 0 );
			m_Button2.EmitSound ( SND_BUTTON_PRESSED );
			BUTTON2_ACTIVATOR = ply;
			}

}

function Reset()
{
BUTTON1 = false;
BUTTON2 = false;

BUTTON1_ACTIVATOR = 0;
BUTTON2_ACTIVATOR = 0;

EntFire( m_Button1_mdl.GetName(), "SetAnimation", "idleoff", 0 );
EntFire( m_Button2_mdl.GetName(), "SetAnimation", "idleoff", 0 );

EntFire( m_Button1.GetName(), "PressOut", "", 1 );
EntFire( m_Button2.GetName(), "PressOut", "", 1 );

}