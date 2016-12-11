//------------------------------------
// Achievements Dialog
//------------------------------------
"CSAchievementsDialog.res"
{	
	"CSAchievementsDialog"
	{
		"ControlName"		        "CCSAchievementsDialog"
		"fieldName"		            "CSAchievementsDialog"
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
		"title"						"#GameUI_Achievements_Title"
		"borderwidth"				"0"
	}
	
	"listpanel_groups"
	{
		"ControlName"	        	"PanelListPanel"
		"fieldName"		            "listpanel_groups"
		"xpos"		                "0"
		"ypos"		                "100"
		"wide"		                "275"
		"tall"		                "567"
		"autoResize"	        	"3"
		"pinCorner"		            "0"
		"visible"		            "1"
		"enabled"		            "1"
		//"tabPosition"	        	"1"
		"scrollbar"                 "0"
	}

	"listpanel_achievements"
	{
		"ControlName"		        "PanelListPanel"
		"fieldName"		            "listpanel_achievements"
		"xpos"		                "274"
		"ypos"		                "100"
		"wide"		                "600"
		"tall"		                "567"
		"autoResize"		        "3"
		"pinCorner"		            "0"
		"visible"		            "1"
		"enabled"		            "1"
		"tabPosition"		        "1"
	}
	
	"listpanel_background"
	{
		"ControlName"	        	"ImagePanel"
		"fieldName"		            "listpanel_background"
		"xpos"		                "274"
		"ypos"		                "100"
		"wide"		                "600"
		"tall"		                "567"
		"fillcolor"	                "32 32 32 255"
		//"zpos"	                    "-3"
		"visible"		            "1"
		"enabled"		            "1"
		"pinCorner"		            "0"
		"autoResize"	        	"3"
	}

	"PercentageBarBackground" //light grey overall percentage
	{
		"ControlName"	        	"ImagePanel"
		"fieldName"		            "PercentageBarBackground"
		"xpos"		                "300"
		"ypos"		                "60"
		"zpos"                      "2"
		"wide"		                "500"
		"tall"		                "16"
		"fillcolor"	                "79 79 79 255"
		"zpos"	                    "-2"
		"visible"		            "0"
		"enabled"		            "1"
	}
	
	"PercentageBar" //dark grey current completed
	{
		"ControlName"		        "ImagePanel"
		"fieldName"	            	"PercentageBar"
		"xpos"		                "300"
		"ypos"		                "60"
		"zpos"                      "3"
		"wide"		                "0"
		"tall"		                "16"
		"fillcolor"	                "157 194 80 255"
		"zpos"	                    "-1"
		"visible"	            	"0"
		"enabled"	            	"1"
	}
	
	"PercentageText" //Percent Text inside the percentage field
	{
		"ControlName"	        	"Label"
		"fieldName"		            "PercentageText"
		"xpos"		                "800"
		"ypos"		                "60"
		"wide"		                "50"
		"tall"		                "20"
		"autoResize"	        	"0"
		"pinCorner"		            "0"
		"visible"		            "0"
		"enabled"		            "1"
		"tabPosition"	        	"0"
		"labelText"		            "0%"
		"textAlignment"	        	"east"
		"dulltext"		            "0"
		"brighttext"	        	"0"
		"wrap"		                "0"
		"fillcolor"	                "157 194 80 255"
		"font"		                "AchievementItemDescription"	//"defaultlarg"
	}
	
	"AchievementsEarnedLabel" 
	{
		"ControlName"	        	"Label"
		"fieldName"		            "AchievementsEarnedLabel"
		"xpos"		                "300"
		"ypos"		                "40"
		"wide"		                "200"
		"tall"		                "20"
		"autoResize"	        	"0"
		"pinCorner"		            "0"
		"visible"		            "1"
		"enabled"		            "1"
		"tabPosition"	        	"0"
		"labelText"		            "#GameUI_Achievements_Earned"
		"textAlignment"	        	"west"
		"dulltext"		            "0"
		"brighttext"	        	"0"
		"wrap"		                "0"
		"font"		                "AchievementItemDescription"	//"defaultlarg"
	}	
	
}