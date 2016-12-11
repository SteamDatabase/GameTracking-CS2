// Command Menu Definition
// 
// "filename.res"
// {
//    "menuitem1"
//    {
//      "label"		"#GoToB"          // lable name shown in game, # = localized string
//      "command"	"echo hallo"      // a command string
//      "toggle"	"sv_cheats" 	  // a 0/1 toggle cvar 
//      "rule"		"map"             // visibility rules : "none", "team", "map","class"	
//      "ruledata"	"de_dust"	  // rule data, eg map name or team number
//    }
//   
//   "menuitem2"
//   {
//	...
//   }
//
//   ...
//
// }
//
//--------------------------------------------------------
// Everything below here is editable

"commandmenu.res"
{
	"menuitem1"
	{
		"label"		"#Cstrike_HELP"
										
		"menuitem11"
		{
			"label"		"#Cstrike_Map_Desc"
			"command"	"!MAPBRIEFING"
		}
		
		"menuitem12"
		{
			"label"		"#Cstrike_Time_Left"
			"command"	"timeleft"
		}
		
		"menuitem13"
		{
			"label"		"#Cstrike_Adjust_Crosshair"
			"command"	"adjust_crosshair"
		}
		
		"menuitem14"
		{
			"label"		"#Cstrike_Use_Right_Hand"
			"toggle"	"cl_righthand"
		}
	}
	
	"menuitem2"
	{
		"label"		"#Cstrike_CHANGE_TEAM"
		"command"	"teammenu"
	}
		
	"menuitem3"
	{
		"label"		"#Cstrike_TEAM_MESSAGE"
		
		// Map Specific
		
		"menuitem1"
		{
			"label"		"#Cstrike_Map_Commands"
			"rule"		"objective"
			"ruledata"	"hostage"
			
			"menuitem1"
			{
				"label"		"#Cstrike_rush_hostage_room"
				"command"	"say_team Rush the hostage room!"
			}
			
			"menuitem2"
			{
				"label"		"#Cstrike_rescue_the_hostages"
				"command"	"say_team Rescue the hostages!"
			}
		}
		
		"menuitem2"
		{
			"label"		"#Cstrike_Map_Commands"
			"rule"		"objective"
			"ruledata"	"bomb"
			
			"menuitem1"
			{
				"label"		"#Cstrike_bomb_at_A"
				"command"	"say_team Bomb is at A!"
			}
			
			"menuitem2"
			{
				"label"		"#Cstrike_bomb_at_B"
				"command"	"say_team Bomb is at B!"
			}
			
			"menuitem3"
			{
				"label"		"#Cstrike_bomb_at_K"
				"command"	"say_team The bomb is in your pants."
			}
		}
		
		"menuitem3"
		{
			"label"		"#Cstrike_Map_Commands"
			"rule"		"objective"
			"ruledata"	"vip"
			
			"menuitem1"
			{
				"label"		"#Cstrike_protect_the_VIP"
				"command"	"say_team Protect the VIP!"
			}
		}
		
		"menuitem4"
		{
			"label"		"#Cstrike_Map_Commands"
			"rule"		"objective"
			"ruledata"	"escape"
			
			"menuitem1"
			{
				"label"		"#Cstrike_get out of here"
				"command"	"say_team Let's get out of here!"
			}
			
			"menuitem2"
			{
				"label"		"#Cstrike_rescue_the_hostages"
				"command"	"say_team Rescue the hostages!"
			}
		}
		
		
	
		"menuitem5"
		{
			"label"		"#Cstrike_Acknowledged"
			"command"	"say_team Acknowledged"
		}
		
		"menuitem6"
		{
			"label"		"#Cstrike_Negative"
			"command"	"say_team Negative"
		}
		
		"menuitem7"
		{
			"label"		"#Cstrike_Go"
			"command"	"say_team Go Go Go!"
		}
		
		"menuitem8"
		{
			"label"		"#Cstrike_On_My_Way"
			"command"	"say_team On my way"
		}
		
		"menuitem9"
		{
			"label"		"#Cstrike_Need_Backup"
			"command"	"say_team Need backup!"
		}
	}
	
	"menuitem4"
	{
		"label"		"#Cstrike_DROP_CURRENT_ITEM"
		"command"	"drop"
	}
}




