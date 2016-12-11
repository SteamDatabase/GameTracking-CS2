//------------------------------------
// Lifetime Stats Page
//------------------------------------
"CSLifetimeStatsDialog.res"
{		
	"CSLifetimeStatsDialog"
	{
		"ControlName"		        "CCSLifetimeStatsDialog"
		"fieldName"		            "CSLifetimeStatsDialog"
		"xpos"		                "0"
		"ypos"		                "0"
		"wide"		                "895"
		"tall"		                "660"
		"autoResize"				"0"
		"pinCorner"					"0"
		"visible"					"1"
		"enabled"					"1"
		"tabPosition"				"0"
		"settitlebarvisible"		"1"
		"title"						"#testres"
		"borderwidth"				"0"
	}
	
	"StatsList"
	{
		"ControlName"	"SectionedListPanel"
		"fieldName"		"StatsList"
		"xpos"		    "274"
		"ypos"		    "124"
		"wide"		    "600"
		"tall"		    "543"
		"zpos"			"10"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"0"
		"autoresize"	"3"
		"linespacing"	"30"
	}
	
	"listpanel_groups"
	{
		"ControlName"	        	"PanelListPanel"
		"fieldName"		            "listpanel_groups"
		"xpos"		                "0"
		"ypos"		                "124"
		"wide"		                "288"
		"tall"		                "543"
		"autoResize"	        	"3"
		"pinCorner"		            "0"
		"visible"		            "1"
		"enabled"		            "1"
		//"tabPosition"	        	"1"
		"scrollbar"                 "0"
	}
	
	"HeaderBar"
	{
		"ControlName"	"ImagePanel"
		"fieldName"		"HeaderBar"
		"xpos"			"0"
		"ypos"			"100"
		"zpos"			"2"
		"wide"			"888"
		"tall"			"24"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"0"
		"fillcolor"		"0 0 0 0" //"ListPanel.BgColor"
		"labelText"		""
		"textAlignment"	"center"
	}
	
	
	"SideBar"
	{
		"ControlName"	"ImagePanel"
		"fieldName"		"SideBar"
		"xpos"			"864"
		"ypos"			"124"
		"zpos"			"2"
		"wide"			"888"
		"tall"			"2400"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"0"
		"fillcolor"		"0 0 0 0" //"ListPanel.BgColor"
		"labelText"		""
		"textAlignment"	"center"
	}
	
	
	"BottomBar"
	{
		"ControlName"	"ImagePanel"
		"fieldName"		"BottomBar"
		"xpos"			"0"
		"ypos"			"124"
		"zpos"			"2"
		"wide"			"864"
		"tall"			"2400"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"0"
		"fillcolor"		"0 0 0 0" //"ListPanel.BgColor"
		"labelText"		""
		"textAlignment"	"center"
	}

	
	"StatHeader"
	{	
		"ControlName"	"Label"
		"fieldName"		"StatHeader"
		"font"			"AchievementItemTitleLarge"
		"xpos"			"290"
		"ypos"			"100"
		"zpos"			"30"
		"wide"			"240"
		"tall"			"24"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"Statistic"
		"textAlignment"	"west"
		"fgcolor_override" "157 194 80 255"
	}
	
	"PersonalHeader"
	{	
		"ControlName"	"Label"
		"fieldName"		"PersonalHeader"
		"font"			"AchievementItemTitleLarge"
		"xpos"			"660"
		"ypos"			"100"
		"zpos"			"30"
		"wide"			"240"
		"tall"			"24"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"Player"
		"textAlignment"	"west"
		"fgcolor_override" "157 194 80 255"
	}
	

}