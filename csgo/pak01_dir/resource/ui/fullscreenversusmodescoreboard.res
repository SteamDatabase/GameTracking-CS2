"Resource/UI/FullscreenVersusModeScoreboard.res"
{
	"fullscreen_vs_scoreboard"
	{
		"ControlName"		"CFullscreenVersusModeScoreboard"
		"fieldName"			"fullscreen_vs_scoreboard"
		"xpos"				"0"
		"ypos"				"0"
		"wide"				"f0"
		"tall"				"480"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"tabPosition"		"0"
		"PaintBackgroundType"	"2"
	}
	
	"CVersusModeScoreboard"
	{
		"ControlName"	"CVersusModeScoreboard"
		"fieldName"		"VersusModeScoreboard"
		"xpos"			"c-300"
		"ypos"			"c-50"
		"wide"			"600"
		"tall"			"220"
		"visible"		"1"
		"enabled"		"1"
		
		"if_split_screen_active"
 		{
			"ypos"		"c-50"
  		}
  		
  		"if_split_screen_vertical"
  		{
			"ypos"		"c-50"
  		}
	}
}
