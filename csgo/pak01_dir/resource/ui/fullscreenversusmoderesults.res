"Resource/UI/FullscreenVersusModeResults.res"
{
	"fullscreen_vs_results"
	{
		"ControlName"		"CFullscreenVersusModeResults"
		"fieldName"			"fullscreen_vs_results"
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
	
	"CVersusModeResults"
	{
		"ControlName"	"CVersusModeResults"
		"fieldName"		"VersusModeResults"
		"xpos"			"c-177" [$ENGLISH]
		"xpos"			"c-182" [!$ENGLISH]
		"ypos"			"95"
		"wide"			"354" [$ENGLISH]
		"wide"			"364" [!$ENGLISH]
		"tall"			"220"
		"visible"		"1"
		"enabled"		"1"
		
		"if_split_screen_active"
 		{
			"ypos"			"95"
  		}
  		
  		"if_split_screen_vertical"
  		{
			"ypos"			"95"
  		}
	}
}
