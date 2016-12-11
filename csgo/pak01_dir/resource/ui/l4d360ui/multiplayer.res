"Resource/UI/Multiplayer.res"
{
	"Multiplayer"
	{
		"ControlName"		"Frame"
		"fieldName"			"Audio"
		"xpos"				"0"
		"ypos"				"0"
		"wide"				"f0"
		"tall"				"378"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"tabPosition"		"0"
	}
	
	"ImgBackground" [$WIN32]
	{
		"ControlName"			"L4DMenuBackground"
		"fieldName"				"ImgBackground"
		"xpos"					"0"
		"ypos"					"99"
		"zpos"					"-1"
		"wide"					"f0"
		"tall"					"241"
		"autoResize"			"0"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"fillColor"				"0 0 0 0"
	}
	
	"DrpLanGamesDiscovery"
	{
		"ControlName"		"DropDownMenu"
		"fieldName"			"DrpLanGamesDiscovery"
		"xpos"				"c-180"
		"ypos"				"110"
		"zpos"				"3"
		"wide"				"360"
		"tall"				"15"
		"visible"			"1"
		"enabled"			"1"
		"usetitlesafe"		"0"
		"tabPosition"		"0"
		"navUp"				"BtnCancel"
		"navDown"			"DrpAllowCustomContent"
				
		//button and label
		"BtnDropButton"
		{
			"ControlName"				"L4D360HybridButton"
			"fieldName"					"BtnDropButton"
			"xpos"						"0"
			"ypos"						"0"
			"zpos"						"0"
			"wide"						"360"
			"wideatopen"				"260"	[$WIN32 && !$WIN32WIDE]
			"tall"						"15"
			"autoResize"				"1"
			"pinCorner"					"0"
			"visible"					"1"
			"enabled"					"1"
			"tabPosition"				"1"
			"AllCaps"					"1"
			"labelText"					"#L4D360UI_Multiplayer_LANDiscovery"
			"tooltiptext"				"#L4D360UI_Multiplayer_LANDiscovery_Tooltip"
			"style"						"DropDownButton"
			"command"					"FlmMpLanGames"
			"ActivationType"			"1"
			"OnlyActiveUser"			"1"
		}
	}
	
	//flyouts		
	"FlmMpLanGames"
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmMpLanGames"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"4"
		"InitialFocus"			"BtnOff"
		"ResourceFile"			"resource/UI/L4D360UI/DropDownMpLanGames.res"
		"OnlyActiveUser"		"1"
	}
	
	"DrpAllowCustomContent"
	{
		"ControlName"		"DropDownMenu"
		"fieldName"			"DrpAllowCustomContent"
		"xpos"				"c-180"
		"ypos"				"130"
		"zpos"				"3"
		"wide"				"360"
		"tall"				"15"
		"visible"			"1"
		"enabled"			"1"
		"usetitlesafe"		"0"
		"tabPosition"		"0"
		"navUp"				"DrpLanGamesDiscovery"
		"navDown"			"DrpSpraypaint"
				
		//button and label
		"BtnDropButton"
		{
			"ControlName"				"L4D360HybridButton"
			"fieldName"					"BtnDropButton"
			"xpos"						"0"
			"ypos"						"0"
			"zpos"						"0"
			"wide"						"360"
			"wideatopen"				"260"	[$WIN32 && !$WIN32WIDE]
			"tall"						"15"
			"autoResize"				"1"
			"pinCorner"					"0"
			"visible"					"1"
			"enabled"					"1"
			"tabPosition"				"1"
			"AllCaps"					"1"
			"labelText"					"#L4D360UI_Multiplayer_AllowCustomContent"
			"tooltiptext"				"#L4D360UI_DownloadFilter_Title"
			"disabled_tooltiptext"		"#L4D360UI_DownloadFilter_Title"
			"style"						"DropDownButton"
			"command"					"FlmAllowCustomContent"
			"ActivationType"			"1"
			"OnlyActiveUser"			"1"
		}
	}
	
	//flyouts		
	"FlmAllowCustomContent"
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmAllowCustomContent"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"4"
		"InitialFocus"			"BtnHeadphones"
		"ResourceFile"			"resource/UI/L4D360UI/DropDownAllowCustomContent.res"
		"OnlyActiveUser"		"1"
	}
	
	"DrpSpraypaint"
	{
		"ControlName"		"DropDownMenu"
		"fieldName"			"DrpSpraypaint"
		"xpos"				"c-180"
		"ypos"				"150"
		"zpos"				"3"
		"wide"				"360"
		"tall"				"15"
		"visible"			"1"
		"enabled"			"1"
		"usetitlesafe"		"0"
		"tabPosition"		"0"
		"navUp"				"DrpAllowCustomContent"
		"navDown"			"BtnBrowseSpraypaint"
				
		//button and label
		"BtnDropButton"
		{
			"ControlName"				"L4D360HybridButton"
			"fieldName"					"BtnDropButton"
			"xpos"						"0"
			"ypos"						"0"
			"zpos"						"0"
			"wide"						"360"
			"wideatopen"				"260"	[$WIN32 && !$WIN32WIDE]
			"tall"						"15"
			"autoResize"				"1"
			"pinCorner"					"0"
			"visible"					"1"
			"enabled"					"1"
			"tabPosition"				"1"
			"AllCaps"					"1"
			"labelText"					"#GameUI_SpraypaintImage"
			"tooltiptext"				"#GameUI_SpraypaintServerNote"
			"disabled_tooltiptext"		"#GameUI_SpraypaintServerNote"
			"style"						"DropDownButton"
			"command"					"FlmSpraypaint"
			"ActivationType"			"1"
			"OnlyActiveUser"			"1"
		}
	}
	
	//flyouts		
	"FlmSpraypaint"
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmSpraypaint"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"4"
		"InitialFocus"			"BtnHeadphones"
		"ResourceFile"			"resource/UI/L4D360UI/DropDownSpraypaint.res"
		"OnlyActiveUser"		"1"
	}
	
	"BtnBrowseSpraypaint"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnBrowseSpraypaint"
		"xpos"					"c-180"
		"ypos"					"170"
		"zpos"					"0"
		"wide"					"200"
		"tall"					"15"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"wrap"					"1"
		"navUp"					"DrpSpraypaint"
		"navDown"				"DrpColorBlind"
		"AllCaps"				"1"
		"labelText"				"#GameUI_ImportSprayEllipsis"
		"tooltiptext"			"#L4D_import_spray_tip"
		"style"					"DefaultButton"
		"command"				"ImportSprayImage"
		EnabledTextInsetX		"2"
		DisabledTextInsetX		"2"
		FocusTextInsetX			"2"
		OpenTextInsetX			"2"
	}
	
	"LogoImage"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"LogoImage"
		"xpos"				"c-180"
		"ypos"				"190"
		"wide"				"64"
		"tall"				"64"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"tabPosition"		"0"
		"border"			"DepressedBorder"
		"scaleImage"		"1"
	}
	
	"DrpColorBlind"
	{
		"ControlName"		"DropDownMenu"
		"fieldName"			"DrpColorBlind"
		"xpos"				"c-180"
		"ypos"				"260"
		"zpos"				"3"
		"wide"				"360"
		"tall"				"15"
		"visible"			"1"
		"enabled"			"1"
		"usetitlesafe"		"0"
		"tabPosition"		"0"
		"navUp"				"BtnBrowseSpraypaint"
		"navDown"			"DrpGameInstructor"
				
		//button and label
		"BtnDropButton"
		{
			"ControlName"				"L4D360HybridButton"
			"fieldName"					"BtnDropButton"
			"xpos"						"0"
			"ypos"						"0"
			"zpos"						"0"
			"wide"						"360"
			"wideatopen"				"260"	[$WIN32 && !$WIN32WIDE]
			"tall"						"15"
			"autoResize"				"1"
			"pinCorner"					"0"
			"visible"					"1"
			"enabled"					"1"
			"tabPosition"				"1"
			"AllCaps"					"1"
			"labelText"					"#L4D360UI_Multiplayer_ColorBlind"
			"tooltiptext"				"#L4D360UI_Multiplayer_ColorBlind_Tooltip"
			"style"						"DropDownButton"
			"command"					"FlmColorBlind"
			"ActivationType"			"1"
			"OnlyActiveUser"			"1"
		}
	}
	
	//flyouts		
	"FlmColorBlind"
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmColorBlind"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"4"
		"InitialFocus"			"BtnOn"
		"ResourceFile"			"resource/UI/L4D360UI/DropDownColorBlind.res"
		"OnlyActiveUser"		"1"
	}
	
	"DrpGameInstructor"
	{
		"ControlName"		"DropDownMenu"
		"fieldName"			"DrpGameInstructor"
		"xpos"				"c-180"
		"ypos"				"280"
		"zpos"				"3"
		"wide"				"360"
		"tall"				"15"
		"visible"			"1"
		"enabled"			"1"
		"usetitlesafe"		"0"
		"tabPosition"		"0"
		"navUp"				"DrpColorBlind"
		"navDown"			"DrpAllowFreeLook"
				
		//button and label
		"BtnDropButton"
		{
			"ControlName"				"L4D360HybridButton"
			"fieldName"					"BtnDropButton"
			"xpos"						"0"
			"ypos"						"0"
			"zpos"						"0"
			"wide"						"360"
			"wideatopen"				"260"	[$WIN32 && !$WIN32WIDE]
			"tall"						"15"
			"autoResize"				"1"
			"pinCorner"					"0"
			"visible"					"1"
			"enabled"					"1"
			"tabPosition"				"1"
			"AllCaps"					"1"
			"labelText"					"#L4D360UI_Multiplayer_Instructor_Enabled"
			"tooltiptext"				"#L4D_import_game_instruct"
			"style"						"DropDownButton"
			"command"					"FlmGameInstructor"
			"ActivationType"			"1"
			"OnlyActiveUser"			"1"
		}
	}
	
	//flyouts		
	"FlmGameInstructor"
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmGameInstructor"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"4"
		"InitialFocus"			"BtnOn"
		"ResourceFile"			"resource/UI/L4D360UI/DropDownGameInstructor.res"
		"OnlyActiveUser"		"1"
	}
	
	"DrpAllowFreeLook"
	{
		"ControlName"		"DropDownMenu"
		"fieldName"			"DrpAllowFreeLook"
		"xpos"				"c-180"
		"ypos"				"300"
		"zpos"				"3"
		"wide"				"360"
		"tall"				"15"
		"visible"			"1"
		"enabled"			"1"
		"usetitlesafe"		"0"
		"tabPosition"		"0"
		"navUp"				"DrpGameInstructor"
		"navDown"			"DrpGore"
				
		//button and label
		"BtnDropButton"
		{
			"ControlName"				"L4D360HybridButton"
			"fieldName"					"BtnDropButton"
			"xpos"						"0"
			"ypos"						"0"
			"zpos"						"0"
			"wide"						"360"
			"wideatopen"				"260"	[$WIN32 && !$WIN32WIDE]
			"tall"						"15"
			"autoResize"				"1"
			"pinCorner"					"0"
			"visible"					"1"
			"enabled"					"1"
			"tabPosition"				"1"
			"AllCaps"					"1"
			"labelText"					"#L4D360UI_Multiplayer_AllowFreeLook"
			"tooltiptext"				"#L4D360UI_Multiplayer_AllowFreeLook_Tooltip"
			"style"						"DropDownButton"
			"command"					"FlmAllowFreeLook"
			"ActivationType"			"1"
			"OnlyActiveUser"			"1"
		}
	}
	
	//flyouts		
	"FlmAllowAllowFreeLook"
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmAllowFreeLook"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"4"
		"InitialFocus"			"BtnHeadphones"
		"ResourceFile"			"resource/UI/L4D360UI/DropDownAllowFreeLook.res"
		"OnlyActiveUser"		"1"
	}
	
	"DrpGore"
	{
		"ControlName"		"DropDownMenu"
		"fieldName"			"DrpGore"
		"xpos"				"c-180"
		"ypos"				"320"
		"zpos"				"1"
		"wide"				"360"
		"tall"				"15"
		"visible"			"1"
		"enabled"			"1"
		"tabPosition"		"0"
		"navUp"				"DrpAllowFreeLook"
		"navDown"			"BtnCancel"
				
		//button and label
		"BtnDropButton"
		{
			"ControlName"			"L4D360HybridButton"
			"fieldName"				"BtnDropButton"
			"xpos"					"0"
			"ypos"					"0"
			"zpos"					"3"
			"wide"					"360"
			"wideatopen"			"260"	[$WIN32 && !$WIN32WIDE]
			"tall"					"15"
			"autoResize"			"1"
			"pinCorner"				"0"
			"visible"				"1"
			"enabled"				"1"
			"tabPosition"			"1"
			"labelText"				"#L4D360UI_VideoOptions_Gore"
			"tooltiptext"			"#L4D360UI_VideoOptions_Tooltip_Gore"
			"disabled_tooltiptext"	"#L4D360UI_VideoOptions_Tooltip_Gore_Disabled"
			"style"					"DropDownButton"
			"command"				"FlmGore"
			"ActivationType"		"1"	
			"OnlyActiveUser"		"1"
		}
	}
	
	//flyouts		
	"FlmGore"
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmGore"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"4"
		"InitialFocus"			"BtnGoreHigh"
		"ResourceFile"			"resource/UI/L4D360UI/DropDownGore.res"
		"OnlyActiveUser"		"1"
	}
		
	"BtnCancel"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnCancel"
		"xpos"					"c-180"
		"ypos"					"340"
		"zpos"					"0"
		"wide"					"200"
		"tall"					"15"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"wrap"					"1"
		"navUp"					"DrpGore"
		"navDown"				"DrpLanGamesDiscovery"
		"AllCaps"				"1"
		"labelText"				"#L4D360UI_Done"
		"tooltiptext"			"#L4D360UI_Tooltip_Back"
		"style"					"RedButton"
		"command"				"Back"
		EnabledTextInsetX		"2"
		DisabledTextInsetX		"2"
		FocusTextInsetX			"2"
		OpenTextInsetX			"2"
	}
}