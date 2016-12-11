//------------------------------------
// Top left corner diplay of the achievements page
//------------------------------------
"CSStatCard.res"
{		
	"CSStatCard"
	{
		"ControlName"		        "StatCard"
		"fieldName"		            "CSStatCard"
		"xpos"		                "0"
		"ypos"		                "0"
		"wide"		                "895"
		"tall"		                "100"
		"autoResize"				"0"
		"pinCorner"					"0"
		"visible"					"1"
		"enabled"					"1"
		"tabPosition"				"0"
		"settitlebarvisible"		"1"
		"title"						"#testres"
		"borderwidth"				"0"
	}
	
	
	"UserStatsBG"
	{
		"ControlName"	        	"ScalableImagePanel"
		"fieldName"		            "UserStatsBG"
		"xpos"		                "10"
		"ypos"		                "10"
		"zpos"                      "2"
		"wide"		                "862"
		"tall"		                "85"
		"fillcolor"	                "86 86 86 255"
		"visible"					"1"
		"enabled"					"1"
		"image"						"../vgui/screens/summary_screen_tab"
		"scaleImage"				"1"
		"src_corner_height"		"25"
		"src_corner_width"		"25"			
		"draw_corner_width"		"25"
		"draw_corner_height" 	"25"
	}
	
	
	"Avatar"
	{
		"ControlName"	            "CAvatarImagePanel"
		"fieldName"		            "Avatar"
		"xpos"			            "30"
		"ypos"			            "20"
		"zpos"			            "3"
		"wide"			            "64"
		"tall"			            "64"
		"visible"		            "1"
		"enabled"		            "1"
		"image"			            ""
		"scaleImage"	        	"1"	
		"color_outline"	        	"52 48 45 255"
	}
	
	
	
	"Name"
	{	
		"ControlName"	"Label"
		"fieldName"		"Name"
		"font"			"AchievementItemTitleLarge"
		"xpos"			"100"
		"ypos"			"22"
		"zpos"			"3"
		"wide"			"800"
		"tall"			"24"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"Name"
		"textAlignment"	"west"
		"fgcolor_override" "255 255 255 255"
	}
	
	"KillToDeath"
	{	
		"ControlName"	"Label"
		"fieldName"		"KillToDeath"
		"font"			"AchievementItemDescription"
		"xpos"			"100"
		"ypos"			"42"
		"zpos"			"3"
		"wide"			"240"
		"tall"			"24"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"KillToDeath"
		"textAlignment"	"west"
		"fgcolor_override" "157 194 80 255"
	}
	
	"Stars"
	{	
		"ControlName"	"Label"
		"fieldName"		"Stars"
		"font"			"AchievementItemDescription"
		"xpos"			"100"
		"ypos"			"62"
		"zpos"			"3"
		"wide"			"240"
		"tall"			"24"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"Stars"
		"textAlignment"	"west"
		"fgcolor_override" "157 194 80 255"
	}
}