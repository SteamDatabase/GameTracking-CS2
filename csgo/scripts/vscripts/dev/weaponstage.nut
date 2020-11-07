/////////////////////////////////////////////////////
// EDIT THESE TO MAKE CHANGES:
/////////////////////////////////////////////////////
// this is the time it takes to change from one weapon to another
m_fTimeBetweenShots <- 0.75
// whether it should loop when it reaches the last weapon (DOESN NOT TAKE SCREENSHOTS IF TRUE)
m_fShouldLoop <- false
// whether it should take screenshots automatically when looping
m_fShouldTakeScreenshots <- true 
// the weapon list.  modify this to change what weapons are in the cycle
weapons <- [
	"w_eq_decoy",
	"w_eq_flashbang",
	"w_eq_fraggrenade",
	"w_eq_incendiarygrenade",
	"w_eq_molotov",
	"w_eq_smokegrenade",
	"w_eq_taser",
	//"w_knife",
	"w_mach_m249para",
	"w_mach_negev",
	"w_pist_deagle",
	"w_pist_elite",
	"w_pist_fiveseven",
	"w_pist_glock18",
	"w_pist_hkp2000",
//	"w_pist_p228",
	"w_pist_p250",
	"w_pist_tec9",
//	"w_pist_usp",
	"w_rif_ak47",
	"w_rif_aug",
	"w_rif_famas",
//	"w_rif_galil",
	"w_rif_galilar",
	"w_rif_galilar",
	"w_rif_m4a1",
//	"w_rif_scar17",
//	"w_rif_sg552",
	"w_rif_sg556",
//	"w_shot_m3super90",
	"w_shot_mag7",
	"w_shot_nova",
	"w_shot_sawedoff",
	"w_shot_xm1014",
	"w_smg_bizon",
	"w_smg_mac10",
//	"w_smg_mp5",
	"w_smg_mp7",
	"w_smg_mp9",
	"w_smg_p90",
//	"w_smg_tmp",
	"w_smg_ump45",
	"w_snip_awp",
	"w_snip_g3sg1",
	"w_snip_scar20",
//	"w_snip_scout",
//	"w_snip_sg550",
	"w_snip_ssg08"
]
/////////////////////////////////////////////////////
/////////////////////////////////////////////////////

m_WeaponModel <- EntityGroup[0]
m_WeaponModelSniper <- EntityGroup[1]
m_WeaponModelSmg <- EntityGroup[2]
m_WeaponModelPistol <- EntityGroup[3]
m_WeaponModelGrenade <- EntityGroup[4]

m_bEnabled <- false
m_fLastShotTime <- 0

m_nShotIndex <- 0


function StartScreenshots()
{
	SendToConsole( "sv_cheats 1" );
	SendToConsole( "cl_drawhud 0" );
	SendToConsole( "mat_postprocess_enable 0" );

	m_bEnabled = true;
}

function WeaponThink()
{
	if ( m_bEnabled )
	{
		if ( m_nShotIndex >= weapons.len() )
		{
			if ( m_fShouldLoop == false )
			{
				m_bEnabled = false;
			}

			m_nShotIndex = 0;
			printl( "reached the end" );
		}

		if ( (m_fLastShotTime + m_fTimeBetweenShots) <= Time() )
		{
			local string = weapons[m_nShotIndex];

			if ( regexp( "^(w_snip_)+" ).search(string) || regexp( "^(w_mach)+" ).search(string) )
			{
				m_WeaponModelSniper.SetModel( "models/weapons/" + weapons[m_nShotIndex] + ".mdl" );
				EntFire( "@camera*", "Disable", "", 0 );
				EntFire( "@camera_sniper", "Enable", "", 0 );
				EntFire( "@flashlight_sniper", "TurnOn", "", 0 );
			}
			else if ( regexp( "^(w_smg_)+" ).search(string) )
			{
				m_WeaponModelSmg.SetModel( "models/weapons/" + weapons[m_nShotIndex] + ".mdl" );
				EntFire( "@camera*", "Disable", "", 0 );
				EntFire( "@camera_smg", "Enable", "", 0 );
				EntFire( "@flashlight_smg", "TurnOn", "", 0 );
			}
			else if ( regexp( "^(w_pist_)+" ).search(string) || regexp( "^(w_eq_taser)+" ).search(string) )
			{
				m_WeaponModelPistol.SetModel( "models/weapons/" + weapons[m_nShotIndex] + ".mdl" );
				EntFire( "@camera*", "Disable", "", 0 );
				EntFire( "@camera_pistol", "Enable", "", 0 );
				EntFire( "@flashlight_pistol", "TurnOn", "", 0 );
			}
			else if ( regexp( "^(w_eq_)+" ).search(string) )
			{
				m_WeaponModelGrenade.SetModel( "models/weapons/" + weapons[m_nShotIndex] + ".mdl" );
				EntFire( "@camera*", "Disable", "", 0 );
				EntFire( "@camera_grenade", "Enable", "", 0 );
				EntFire( "@flashlight_grenade", "TurnOn", "", 0 );
			}
			else
			{
				m_WeaponModel.SetModel( "models/weapons/" + weapons[m_nShotIndex] + ".mdl" );
				EntFire( "@camera*", "Disable", "", 0 );
				EntFire( "@camera", "Enable", "", 0 );
				EntFire( "@flashlight", "TurnOn", "", 0 );
			}

			if ( m_fShouldLoop == false && m_fShouldTakeScreenshots == true )
			{
				SendToConsole( "cl_screenshotname " + weapons[m_nShotIndex] );
				SendToConsole( "screenshot" );
			}
		
			m_fLastShotTime = Time();
			//printl( "models/weapons/" + weapons[m_nShotIndex] + ".mdl ======= " + m_nShotIndex  );
			m_nShotIndex++;
		}
	}
}