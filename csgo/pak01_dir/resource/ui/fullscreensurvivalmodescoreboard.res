"Resource/UI/FullscreenSurvivalModeScoreboard.res"
{
	"fullscreen_survival_scoreboard"
	{
		"ControlName"		"CFullscreenSurvivalModeScoreboard"
		"fieldName"			"fullscreen_survival_scoreboard"
		"xpos"				"0"
		"ypos"				"0"
		"wide"				"f0"
		"tall"				"480"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"0"
		"enabled"			"1"
		"tabPosition"		"0"
		"PaintBackgroundType"	"2"
	}
	
	"ImgBackground"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"ImgBackground"
		"xpos"					"0"
		"ypos"					"115" [$WIN32]
		"ypos"					"120" [$X360]
		"zpos"					"-1"
		"wide"					"f0"
		"tall"					"180"
		"autoResize"			"0"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"fillColor"				"0 0 0 230"
	} 

	"ScoreboardImgBackground" [$X360]
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"ScoreboardImgBackground"
		"xpos"					"c-250"
		"ypos"					"115"	[$WIN32]
		"ypos"					"120"	[$X360]
		"zpos"					"-3"
		"wide"					"315"
		"tall"					"180"
		"autoResize"			"0"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"fillColor"				"0 0 0 100"
	} 
	
	"CSurvivalModeScoreboard"
	{
		"ControlName"	"CSurvivalModeScoreboard"
		"fieldName"		"SurvivalModeScoreboard"
		"xpos"			"c-250"
		"ypos"			"115"	[$WIN32]
		"ypos"			"120"	[$X360]
		"wide"			"500"
		"tall"			"260"
		"visible"		"1"
		"enabled"		"1"
		
		"if_split_screen_active"
 		{
			"ypos"		"180"
  		}
  		
  		"if_split_screen_vertical"
  		{
  			"ypos"			"260"
  		}
	}
}
