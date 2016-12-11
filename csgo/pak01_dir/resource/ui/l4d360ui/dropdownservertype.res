"Resource/UI/DropDownServerType.res"
{
	"PnlBackground"
	{
		"ControlName"		"Panel"
		"fieldName"			"PnlBackground"
		"xpos"				"0"
		"ypos"				"0"
		"zpos"				"1"
		"wide"				"146"	[$X360]
		"wide"				"146"	[$WIN32 && $ENGLISH]
		"wide"				"166"	[$WIN32 && !$ENGLISH]
		"tall"				"65" [$WIN32]
		"tall"				"45" [$X360]
		"visible"			"1"
		"enabled"			"1"
		"paintbackground"	"1"
		"paintborder"		"1"
	}

	"BtnOfficial"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"			"BtnOfficial"
		"xpos"				"0"
		"ypos"				"0"
		"zpos"				"2"
		"wide"				"140"
		"tall"				"20"
		"autoResize"			"1"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"tabPosition"			"0"
		"wrap"				"1"
		"navUp"				"BtnListen"
		"navDown"			"BtnDedicated" [$WIN32]
		"navDown"			"BtnListen" [$X360]
		"labelText"			"#L4D360UI_ServerType_Official"
		"tooltiptext"			"#L4D360UI_Lobby_Change_ServerType_Official_Tip"
		"disabled_tooltiptext"		"#L4D360UI_Lobby_Change_ServerType_Dedicated_Disabled_Tip"
		"style"				"FlyoutMenuButton"
		"command"			"#L4D360UI_ServerType_Official"
		"EnableCondition" 		"LiveRequired"		
	}
	

	"BtnDedicated" [$WIN32]
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"			"BtnDedicated"
		"xpos"				"0"
		"ypos"				"20"
		"zpos"				"2"
		"wide"				"140"
		"tall"				"20"
		"autoResize"			"1"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"tabPosition"			"0"
		"wrap"				"1"
		"navUp"				"BtnOfficial"
		"navDown"			"BtnListen"
		"labelText"			"#L4D360UI_Lobby_ServerType_Dedicated"
		"tooltiptext"			"#L4D360UI_Lobby_Change_ServerType_Dedicated_Tip"
		"disabled_tooltiptext"		"#L4D360UI_Lobby_Change_ServerType_Dedicated_Disabled_Tip"
		"style"				"FlyoutMenuButton"
		"command"			"#L4D360UI_ServerType_Dedicated"
		"EnableCondition" 		"LiveRequired"		
	}
	
	"BtnListen"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnListen"
		"xpos"					"0"
		"ypos"					"40" [$WIN32]
		"ypos"					"20" [$X360]
		"zpos"					"2"
		"wide"					"140"
		"tall"					"20"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"wrap"					"1"
		"navUp"					"BtnDedicated" [$WIN32]
		"navUp"					"BtnOfficial" [$X360]
		"navDown"				"BtnOfficial"
		"labelText"		"#L4D360UI_ServerType_Listen"
		"tooltiptext"		"#L4D360UI_Lobby_Change_ServerType_Listen_Tip"
		"style"			"FlyoutMenuButton"
		"command"		"#L4D360UI_ServerType_Listen"
		"EnableCondition" 	"LiveRequired"		
	}
	
}