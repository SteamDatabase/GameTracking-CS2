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

"spectatormenu.res"
{
	"menuitem1"
	{
		"label"		"#Valve_Close"	// name shown in game
		"command"	"spec_menu 0"	// type data
	}
	
	"menuitem5"
	{
		"label"		"#Valve_Show_Scores"
		"command"	"togglescores"
	}
}

// Here are the rest of the buttons and submenus
// You can change these safely if you want.






